class QuestionViewController < UIViewController
  attr_accessor :index
  attr_accessor :state
  
  attr_accessor :questionLabel
  attr_accessor :upButton
  attr_accessor :downButton
  
  def viewDidLoad
    super
    
    self.view.backgroundColor = UIColor.blackColor
    
    self.questionLabel = UILabel.alloc.initWithFrame(CGRectMake(0, 0, 0, 0)).tap do |label|
      label.text                            = UIApplication.sharedApplication.delegate.upDownController.questions[self.index][:text]
      label.font                            = UIFont.boldSystemFontOfSize(44)
      label.numberOfLines                   = 0
      label.adjustsLetterSpacingToFitWidth  = true
      label.adjustsFontSizeToFitWidth       = true
      label.textAlignment                   = NSTextAlignmentCenter
      label.textColor                       = UIColor.whiteColor
      self.view.addSubview(label)
    end
    
    self.upButton = UIButton.alloc.initWithFrame(CGRectMake(0, 0, 0, 0)).tap do |button|
      button.addTarget(self, action:"up:", forControlEvents:UIControlEventTouchUpInside)
      button.setBackgroundImage(UIImage.imageNamed("Up-Button-Background.png"), forState:UIControlStateNormal)
      self.view.addSubview(button)
    end
    
    self.downButton = UIButton.alloc.initWithFrame(CGRectMake(0, 0, 0, 0)).tap do |button|
      button.addTarget(self, action:"down:", forControlEvents:UIControlEventTouchUpInside)
      button.setBackgroundImage(UIImage.imageNamed("Down-Button-Background.png"), forState:UIControlStateNormal)
      self.view.addSubview(button)
    end
    
  end
  
  def up(sender)
    NSLog("up")
    
    self.parentViewController.setViewControllers([self.parentViewController.viewControllerAtIndex(self.index, withState:2)], direction:UIPageViewControllerNavigationDirectionForward, animated:true, completion:lambda { |finished|  })
  end
  
  def down(sender)
    NSLog("down")
    
    self.parentViewController.setViewControllers([self.parentViewController.viewControllerAtIndex(self.index, withState:0)], direction:UIPageViewControllerNavigationDirectionReverse, animated:true, completion:lambda { |finished|  })
  end
  
  def viewWillLayoutSubviews
    super
    
    self.questionLabel.frame  = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
    self.upButton.frame       = CGRectMake((self.view.frame.size.width - 100) / 2, self.view.frame.size.height-120-20, 100, 100)
    self.downButton.frame     = CGRectMake((self.view.frame.size.width - 100) / 2, 30+20, 100, 100)
  end
end