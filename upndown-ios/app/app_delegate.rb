class AppDelegate
  attr_accessor :window
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    self.window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    self.window.rootViewController = UpAndDownViewController.alloc.init
    self.window.makeKeyAndVisible
    
    true
  end
end
