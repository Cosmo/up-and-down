class AppDelegate
  attr_accessor :window
  attr_accessor :joinViewController
  attr_accessor :upDownController
  attr_accessor :host
  attr_accessor :port
  attr_accessor :partyId
  
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    
    NSLog("app delegate")
    
    self.window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    self.joinViewController = JoinViewController.alloc.init
    self.window.rootViewController = self.joinViewController
    self.window.makeKeyAndVisible
    
    true
  end
  
  def application(application, handleOpenURL:url)
    
    NSLog("url handler")
    
    self.host     = url.host
    self.port     = url.port
    self.partyId  = url.path.split("/").last
    
    NSLog("Handle url event: #{url.absoluteString}")
    
    data = { name: "Klaus" + rand(100000).to_s }
    BW::HTTP.post("http://#{self.host}:#{self.port}/parties/#{self.partyId}/user", { payload: data }) do |response|
      if response.ok?
        # json = BW::JSON.parse(response.body.to_str)
        # p json['id']
        # NSLog("works.")
        NSLog(response.body.to_str)
        
        BW::HTTP.get("http://#{self.host}:#{self.port}/parties/#{self.partyId}/questions") do |response|
          
          puts (BW::JSON.parse(response.body.to_str))
          
          self.upDownController = UpAndDownViewController.alloc.initWithTransitionStyle(UIPageViewControllerTransitionStyleScroll, navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal, options: { "UIPageViewControllerOptionInterPageSpacingKey" => NSNumber.numberWithFloat(15.0) })
          self.upDownController.questions = (BW::JSON.parse(response.body.to_str))
          self.joinViewController.presentViewController(self.upDownController, animated:true, completion:nil)
        end
        
      elsif response.status_code.to_s =~ /40\d/
        App.alert("40x, Failed")
      else
        App.alert(response.error_message)
      end
    end
    
  end
end
