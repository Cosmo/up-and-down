class DoneViewController < UIViewController
  attr_accessor :doneLabel
  
  def viewDidLoad
    super
    
    self.view.backgroundColor = UIColor.yellowColor
    
    self.doneLabel = UILabel.alloc.initWithFrame(CGRectMake(0, 0, 0, 0)).tap do |label|
      label.text                            = "Done! Look at the TV-Screen."
      label.font                            = UIFont.boldSystemFontOfSize(44)
      label.numberOfLines                   = 0
      label.adjustsLetterSpacingToFitWidth  = true
      label.adjustsFontSizeToFitWidth       = true
      label.textAlignment                   = NSTextAlignmentCenter
      label.textColor                       = UIColor.blackColor
      self.view.addSubview(label)
    end
  end
  
  def viewWillLayoutSubviews
    self.doneLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
  end
end