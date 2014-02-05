class QuestionAnswersViewController < UIPageViewController
  def viewDidLoad
    super
    
    self.dataSource = self
    
    self.setViewControllers([QuestionViewController.alloc.init], direction: UIPageViewControllerNavigationDirectionForward, animated:true, completion: nil)
  end
  
  def pageViewController(pageViewController, viewControllerBeforeViewController:viewController)
    UpViewController.alloc.init
  end
  
  def pageViewController(pageViewController, viewControllerAfterViewController:viewController)
    DownViewController.alloc.init
  end
end