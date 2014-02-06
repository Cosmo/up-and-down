class QuestionAnswersViewController < UIPageViewController
  attr_accessor :index
  
  def viewDidLoad
    super
    
    self.dataSource = self
    self.delegate   = self
    
    viewController = self.viewControllerAtIndex(self.index, withState:1)
    self.setViewControllers([viewController], direction: UIPageViewControllerNavigationDirectionForward, animated:true, completion: nil)
  end
  
  def viewControllerAtIndex(index, withState:state)
    if state == 0
      # down
      viewController = DownViewController.alloc.init
    end
    if state == 1
      # question
      viewController = QuestionViewController.alloc.init
    end
    if state == 2
      # up
      viewController = UpViewController.alloc.init
    end
    
    viewController.index = index
    viewController.state = state
    viewController
  end
  
  def pageViewController(pageViewController, viewControllerBeforeViewController:viewController)
    state = viewController.state
    
    if state == 0
      return nil
    end
    
    state -= 1
    
    return self.viewControllerAtIndex(self.index, withState:state)
  end
  
  def pageViewController(pageViewController, viewControllerAfterViewController:viewController)
    state = viewController.state

    state += 1

    if state == 3
      return nil
    end

    return self.viewControllerAtIndex(self.index, withState:state)
  end
  
  # def presentationCountForPageViewController(pageViewController)
  #   3
  # end
  # 
  # def presentationIndexForPageViewController(pageViewController)
  #   self.state
  # end
  
  def pageViewController(pageViewController, didFinishAnimating:finished, previousViewControllers:previousViewControllers, transitionCompleted:completed)
    
    puts pageViewController.viewControllers.last.class
    
    case pageViewController.viewControllers.last.class.to_s
    when "UpViewController"
      NSLog("Up")
    when "DownViewController"
      NSLog("Down")
    when "QuestionViewController"
      NSLog("Question")
    end
    
    # puts "lol"
    # NSLog(pageViewController.viewControllers.lastObject.state)
    # def finished
    #   # NSLog(pageViewController.viewControllers.lastObject.state)
    #   NSLog("lol")
    # end
  end
end