class QuestionAnswersViewController < UIPageViewController
  attr_accessor :index
  
  def viewDidLoad
    super
    
    self.dataSource = self
    self.delegate   = self
    
    viewController = self.viewControllerAtIndex(self.index, withState:1)
    self.setViewControllers([viewController], direction: UIPageViewControllerNavigationDirectionForward, animated:true, completion: nil)
    
    $vc = self
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
  
  def pageViewController(pageViewController, didFinishAnimating:finished, previousViewControllers:previousViewControllers, transitionCompleted:completed)
    
    move = false
    
    appDelegate = UIApplication.sharedApplication.delegate
    
    id = appDelegate.upDownController.questions[self.index]["id"]
    
    case pageViewController.viewControllers.last.class.to_s
    when "UpViewController"
      NSLog("Up")
      move = true
      
      
      BW::HTTP.put("http://#{appDelegate.host}:#{appDelegate.port}/parties/#{appDelegate.partyId}/questions/#{id}", { payload: { upped: "true" } }) do |response|
        if response.ok?
          puts "#{id} upped"
        end
      end
      
    when "DownViewController"
      NSLog("Down")
      move = true
      
      BW::HTTP.put("http://#{appDelegate.host}:#{appDelegate.port}/parties/#{appDelegate.partyId}/questions/#{id}", { payload: { upped: "false" } }) do |response|
        if response.ok?
          puts "#{id} down"
        end
      end
      
    when "QuestionViewController"
      NSLog("Question")
    end
    
    index = self.index+1
    
    if(index < self.parentViewController.questions.count)
      if move
        self.parentViewController.setViewControllers([self.parentViewController.viewControllerAtIndex(index)], direction:UIPageViewControllerNavigationDirectionForward, animated:true, completion:lambda { |finished|  })
      end
    else
      NSLog("END!")
      self.parentViewController.showDone
    end
    
  end
end