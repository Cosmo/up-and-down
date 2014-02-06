class UpAndDownViewController < UIPageViewController
  attr_accessor :questions
  
  def viewDidLoad
    super
    
    self.dataSource = self
    
    
    self.questions = [
      { upped: true,  text: "Michael Fassbender" },
      { upped: false, text: "80s" },
      { upped: true,  text: "Recently released" },
      { upped: true,  text: "Comedy" },
      { upped: true,  text: "Popular" },
      { upped: true,  text: "R-Rating" }
    ]
    
    viewController = self.viewControllerAtIndex(0)
    self.setViewControllers([viewController], direction: UIPageViewControllerNavigationDirectionForward, animated:true, completion: nil)
  end
  
  def viewControllerAtIndex(index)
    # questionViewController = QuestionViewController.alloc.init
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
  
end