class AnswerViewController < UIViewController
  attr_accessor :index
  attr_accessor :state
  
  attr_accessor :questionLabel
  
  def viewDidLoad
    super
    
    self.questionLabel = UILabel.alloc.initWithFrame(CGRectMake(0, 0, 0, 0)).tap do |label|
      label.text                            = UIApplication.sharedApplication.delegate.upDownController.questions[self.index]["question"]["text"]
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
    
    self.questionLabel.frame  = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
  end
end