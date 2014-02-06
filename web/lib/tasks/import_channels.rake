def request_data(body)
  uri               = URI.parse("https://c7528448.ipg.web.cddbp.net/webapi/xml/1.0/")
  http              = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl      = true
  http.verify_mode  = OpenSSL::SSL::VERIFY_NONE
  http.ssl_version  = :SSLv3

  request           = Net::HTTP::Post.new(uri.request_uri)
  request.body      = body
  response          = http.request(request)
  document          = Nokogiri::XML(response.body)
end

def provider_lookup(postal_code)
  puts body = %Q(<QUERIES>
  <AUTH>
    <CLIENT></CLIENT>
    <USER></USER>
  </AUTH>
  <LANG>eng</LANG>
  <COUNTRY>usa</COUNTRY>
  <QUERY CMD="TVPROVIDER_LOOKUP">
    <POSTALCODE>#{postal_code}</POSTALCODE>
  </QUERY>
</QUERIES>)
  response = request_data(body)

  if response.css("RESPONSE").first["STATUS"] == "OK"
    providers = response.css("TVPROVIDER")
    providers.each_with_index do |provider, index|
      puts "#{index + 1} #{provider.css("NAME").text} (#{provider.css("PROVIDERTYPE").text})"
    end
    print "= Select provider: "
    input = $stdin.gets.chomp
    provider = providers[input.to_i - 1]
    puts "+ Provider selected: #{provider.css("NAME").text} (#{provider.css("PROVIDERTYPE").text})"
    channel_import(provider.css("GN_ID").text)
  end
end

def channel_import(provider_gn_id)
  puts body = %Q(<QUERIES>
  <AUTH>
    <CLIENT></CLIENT>
    <USER></USER>
  </AUTH>
  <LANG>eng</LANG>
  <QUERY CMD="TVCHANNEL_LOOKUP">
    <MODE>TVPROVIDER</MODE>
    <GN_ID>#{provider_gn_id}</GN_ID>
    <OPTION>
      <PARAMETER>SELECT_EXTENDED</PARAMETER>
      <VALUE>IMAGE</VALUE>
    </OPTION>
  </QUERY>
</QUERIES>)
  response = request_data(body)

  if response.css("RESPONSE").first["STATUS"] == "OK"
    channels = response.css("TVCHANNEL")
    channels.each do |channel|

      db_channel = Channel.where(gn: channel.css("GN_ID").text).first_or_initialize
      if db_channel.new_record?
        db_channel.name       = channel.css("NAME").text
        db_channel.name_short = channel.css("NAME_SHORT").text
        db_channel.image_url  = channel.css("URL").text unless channel.css("URL").text == ""
        db_channel.save
        puts "+ Channel saved: #{db_channel.name_short}"
      else
        puts "= Channel already exists: #{db_channel.name_short}"
      end
    end

    time_format = "%Y-%m-%dT%H:%M"
    begins_at   = Time.zone.now.utc
    ends_at     = Time.zone.now.utc + 1.day

    params = {
      begins_at: begins_at.strftime(time_format),
      ends_at: ends_at.strftime(time_format),
      start: 0
    }

    db_channels = Channel.where("image_url IS NOT NULL")
    tvgrid_lookup(db_channels, params)
  end
end

def tvgrid_lookup(db_channels, params)
  puts body = %Q(<QUERIES>
 <LANG>eng</LANG>
 <AUTH>
   <CLIENT></CLIENT>
   <USER></USER>
 </AUTH>
  <QUERY CMD="TVGRID_LOOKUP">
    <TVCHANNEL>
      #{db_channels.map { |c| "<GN_ID>"+c.gn+"</GN_ID>" }}
    </TVCHANNEL>
    <DATE TYPE="START">#{params[:begins_at]}</DATE>
    <DATE TYPE="END">#{params[:ends_at]}</DATE>
    <RANGE>
      <START>#{params[:start]}</START>
      #{ "<END>"+params[:end]+"</END>" if params[:end] }
    </RANGE>
    <OPTION>
      <PARAMETER>SELECT_EXTENDED</PARAMETER>
      <VALUE>TVPROGRAM_IMAGE,IPGCATEGORY_IMAGE</VALUE>
    </OPTION>
    <OPTION>
      <PARAMETER>IMAGE_SIZE</PARAMETER>
      <VALUE>XLARGE</VALUE>
    </OPTION>
  </QUERY>
</QUERIES>)
  response = request_data(body)

  if response.css("RESPONSE").first["STATUS"] == "OK"
    import_programs(response)

    range = response.css("RANGE")
    puts "= End: #{range.css("END").text}, Count: #{range.css("COUNT").text}"
    if range.css("END").text.to_i < range.css("COUNT").text.to_i
      params[:start] = range.css("END").text
      params[:end]   = range.css("COUNT").text

      puts "= Request #{params[:start]} of #{params[:end]} broadcasts"

      tvgrid_lookup(db_channels, params)
    end
  end
end

def import_programs(response)
  tv_programs = response.css("TVPROGRAM")
  tv_airings  = response.css("TVAIRING")

  tv_programs_mapped = {}
  tv_programs.each do |tv_program|
    tv_programs_mapped[tv_program.css("GN_ID").text] = tv_program
  end

  tv_airings.each do |tv_airing|
    tv_program = tv_programs_mapped[tv_airing["TVPROGRAM_GN_ID"]]

    if epg_production_type = tv_program.css("EPGPRODUCTION_TYPE").first
      epg_production_type_id = epg_production_type["ID"]
    else
      epg_production_type_id = nil
    end

    if epg_production_type_id == "68047"
      db_channel   = Channel.where(gn: tv_airing["TVCHANNEL_GN_ID"]).first
      db_broadcast = Broadcast.where(gn: tv_airing["TVPROGRAM_GN_ID"], channel_id: db_channel).first_or_initialize

      if db_broadcast.new_record?
        db_broadcast.channel    = db_channel
        db_broadcast.title      = tv_program.css("TITLE").text
        db_broadcast.begins_at  = DateTime.parse(tv_airing["START"])
        db_broadcast.ends_at    = DateTime.parse(tv_airing["END"])

        if tv_program_image = tv_program.css("URL").first
          if tv_program_image["TYPE"] == "IMAGE"
            db_broadcast.image_url = tv_program_image.text
          end
        end
        
        db_broadcast.save

        puts "= New broadcast: #{db_broadcast.title} @ #{db_broadcast.channel.name_short} (#{db_broadcast.begins_at} - #{db_broadcast.ends_at})"
      else
        puts "- Broadcast already exists."
      end
    end
  end
end

namespace :import do
  task :gracenote => :environment do
    require "net/https"
    require "uri"
    
    Rails.logger.level = Logger::WARN
    
    print "= Enter postal code (e.g. 94103): "
    input = $stdin.gets.chomp

    provider_lookup(input.to_s)
  end
end