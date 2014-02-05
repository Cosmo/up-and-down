class QuestionViewController < UIViewController
  attr_accessor :questionLabel
  attr_accessor :upButton
  attr_accessor :downButton
  
  def viewDidLoad
    super
    
    self.view.backgroundColor = UIColor.blueColor
    
    self.questionLabel = UILabel.alloc.initWithFrame(CGRectMake(0, 0, 0, 0)).tap do |label|
      label.text = ["Kevin Costner", "80s", "Recently released", "Comedy", "Popuplar", "R-Rating"].sample
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
      # button.setBackgroundImage(UIImage.imageNamed("Up-Button-Background.png"), forState:UIControlStateNormal)
      button.backgroundColor = UIColor.colorWithRed(255/255.0, green:0/255.0, blue:0/255.0, alpha:1.0)
      self.view.addSubview(button)
    end
    
    self.downButton = UIButton.alloc.initWithFrame(CGRectMake(0, 0, 0, 0)).tap do |button|
      button.addTarget(self, action:"down:", forControlEvents:UIControlEventTouchUpInside)
      # button.setBackgroundImage(UIImage.imageNamed("Down-Button-Background.png"), forState:UIControlStateNormal)
      button.backgroundColor = UIColor.colorWithRed(0/255.0, green:255/255.0, blue:0/255.0, alpha:1.0)
      self.view.addSubview(button)
    end
    
  end
  
  def up(sender)
    NSLog("up")
  end
  
  def down(sender)
    NSLog("down")
  end
  
  def viewWillLayoutSubviews
    self.questionLabel.frame  = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
    self.upButton.frame       = CGRectMake((self.view.frame.size.width - 100) / 2, 30, 100, 100)
    self.downButton.frame     = CGRectMake((self.view.frame.size.width - 100) / 2, self.view.frame.size.height - 120, 100, 100)
  end
end