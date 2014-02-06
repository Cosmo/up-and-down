class JoinViewController < UIViewController
  attr_accessor :hintLabel
  
  def viewDidLoad
    super
    
    self.view.backgroundColor = UIColor.blackColor
    
    self.hintLabel = UILabel.alloc.initWithFrame(CGRectMake(0, 0, 0, 0)).tap do |label|
      label.text                            = "Scan QR-Code"
      label.font                            = UIFont.boldSystemFontOfSize(44)
      label.numberOfLines                   = 0
      label.adjustsLetterSpacingToFitWidth  = true
      label.adjustsFontSizeToFitWidth       = true
      label.textAlignment                   = NSTextAlignmentCenter
      label.textColor                       = UIColor.whiteColor
      self.view.addSubview(label)
    end
  end
  
  def viewWillLayoutSubviews
    super
    
    self.hintLabel.frame  = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
  end
end