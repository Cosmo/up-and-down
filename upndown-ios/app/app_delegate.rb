class AppDelegate
  attr_accessor :window
  attr_accessor :upDownController
  attr_accessor :host
  attr_accessor :port
  attr_accessor :partyId
  
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    
    self.window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    self.upDownController = UpAndDownViewController.alloc.initWithTransitionStyle(UIPageViewControllerTransitionStyleScroll, navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal, options: { "UIPageViewControllerOptionInterPageSpacingKey" => NSNumber.numberWithFloat(15.0) })
    self.window.rootViewController = self.upDownController
    self.window.makeKeyAndVisible
    
    true
  end
  
  def application(application, handleOpenURL:url)
    self.host     = url.host
    self.port     = url.port
    self.partyId  = url.path.split("/").last
    
    NSLog("Handle url event: #{url.absoluteString}")
  end
end
