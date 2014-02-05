class QuestionViewController < UIViewController
  def viewDidLoad
    super
    
    self.view.backgroundColor = UIColor.blueColor
    
    dummyBox = UIView.alloc.init
    dummyBox.backgroundColor = UIColor.redColor
    dummyBox.frame = CGRectMake(0, 0, 100, 100)
    
    self.view.addSubview(dummyBox)
  end
end