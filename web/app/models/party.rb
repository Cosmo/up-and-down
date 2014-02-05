class Party < ActiveRecord::Base
  before_create :generate_vanity

  def generate_vanity
    begin
      self.vanity = rand(1111..9999)
    end while self.class.exists?(:vanity => self.vanity)
  end
end