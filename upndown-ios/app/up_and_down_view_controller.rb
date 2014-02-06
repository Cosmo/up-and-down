class UpAndDownViewController < UIPageViewController
  attr_accessor :questions
  
  def viewDidLoad
    super
    
    self.dataSource = self
    
    appDelegate = UIApplication.sharedApplication.delegate
    
    BW::HTTP.get("http://#{appDelegate.host}:#{appDelegate.port}/parties/#{appDelegate.partyId}/questions") do |response|
      p response.body.to_str
    end
    
    self.questions = [
      { state: 1, text: "Michael Fassbender" },
      { state: 1, text: "80s" },
      { state: 1, text: "Recently released" },
      { state: 1, text: "Comedy" },
      { state: 1, text: "Popular" },
      { state: 1, text: "R-Rating" }
    ]
    
    viewController = self.viewControllerAtIndex(0)
    self.setViewControllers([viewController], direction: UIPageViewControllerNavigationDirectionForward, animated:true, completion: nil)
  end
  
  def preferredStatusBarStyle
    UIStatusBarStyleLightContent
  end
  
  def viewControllerAtIndex(index)
    questionViewController = QuestionAnswersViewController.alloc.initWithTransitionStyle(UIPageViewControllerTransitionStyleScroll, navigationOrientation:UIPageViewControllerNavigationOrientationVertical, options: { "UIPageViewControllerOptionInterPageSpacingKey" => NSNumber.numberWithFloat(15.0) })
    questionViewController.index = index
    questionViewController
  end
  
  def pageViewController(pageViewController, viewControllerBeforeViewController:viewController)
    index = viewController.index
    
    if index == 0
      return nil
    end
    
    index -= 1
    
    return self.viewControllerAtIndex(index)
  end
  
  def pageViewController(pageViewController, viewControllerAfterViewController:viewController)
    index = viewController.index

    index += 1

    if index == self.questions.count
      return nil
    end

    return self.viewControllerAtIndex(index)
  end
  
  def showDone
    viewController = DoneViewController.alloc.init
    self.presentViewController(viewController, animated:true, completion:nil)
  end
  
end