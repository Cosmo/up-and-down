class UpAndDownViewController < UIPageViewController
  def viewDidLoad
    super
    
    self.dataSource = self
    
    viewController = QuestionAnswersViewController.alloc.initWithTransitionStyle(UIPageViewControllerTransitionStyleScroll, navigationOrientation:UIPageViewControllerNavigationOrientationVertical, options: { "UIPageViewControllerOptionInterPageSpacingKey" => NSNumber.numberWithFloat(15.0) })
    self.setViewControllers([viewController], direction: UIPageViewControllerNavigationDirectionForward, animated:true, completion: nil)
  end
  
  def pageViewController(pageViewController, viewControllerBeforeViewController:viewController)
    QuestionAnswersViewController.alloc.initWithTransitionStyle(UIPageViewControllerTransitionStyleScroll, navigationOrientation:UIPageViewControllerNavigationOrientationVertical, options: { "UIPageViewControllerOptionInterPageSpacingKey" => NSNumber.numberWithFloat(15.0) })
  end
  
  def pageViewController(pageViewController, viewControllerAfterViewController:viewController)
    QuestionAnswersViewController.alloc.initWithTransitionStyle(UIPageViewControllerTransitionStyleScroll, navigationOrientation:UIPageViewControllerNavigationOrientationVertical, options: { "UIPageViewControllerOptionInterPageSpacingKey" => NSNumber.numberWithFloat(15.0) })
  end
end