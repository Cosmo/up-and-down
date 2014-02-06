class AppDelegate
  attr_accessor :window
  attr_accessor :upDownController
  
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    
    self.window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    self.upDownController = UpAndDownViewController.alloc.initWithTransitionStyle(UIPageViewControllerTransitionStyleScroll, navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal, options: { "UIPageViewControllerOptionInterPageSpacingKey" => NSNumber.numberWithFloat(15.0) })
    self.window.rootViewController = self.upDownController
    self.window.makeKeyAndVisible
    
    true
  end
end
