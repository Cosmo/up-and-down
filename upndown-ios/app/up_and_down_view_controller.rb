class UpAndDownViewController < UIPageViewController
  attr_accessor :questions
  
  def viewDidLoad
    super
    
    self.dataSource = self
    
    appDelegate = UIApplication.sharedApplication.delegate
    
    # BW::HTTP.get("http://#{appDelegate.host}:#{appDelegate.port}/parties/#{appDelegate.partyId}/questions") do |response|
    #   puts (BW::JSON.parse(response.body.to_str))
    #   self.questions = (BW::JSON.parse(response.body.to_str))
    # end
    
    # self.questions = [
    #   { state: 1, text: "Michael Fassbender" },
    #   { state: 1, text: "80s" },
    #   { state: 1, text: "Recently released" },
    #   { state: 1, text: "Comedy" },
    #   { state: 1, text: "Popular" },
    #   { state: 1, text: "R-Rating" }
    # ]
    
    if self.questions.nil?
      self.questions = []
    end
    
    # self.questions = [{"user_id"=>3, "question_id"=>1, "id"=>32, "created_at"=>"2014-02-06T21:42:03.405Z", "upped"=>nil, "updated_at"=>"2014-02-06T21:42:03.405Z", "question"=>{"updated_at"=>"2014-02-06T21:25:44.325Z", "id"=>1, "text"=>"Leonard DiCaprio", "created_at"=>"2014-02-06T21:25:44.325Z"}},
    #   {"user_id"=>3, "question_id"=>2, "id"=>26, "created_at"=>"2014-02-06T21:42:03.385Z", "upped"=>nil, "updated_at"=>"2014-02-06T21:42:03.385Z", "question"=>{"updated_at"=>"2014-02-06T21:25:44.331Z", "id"=>2, "text"=>"Most Popular", "created_at"=>"2014-02-06T21:25:44.331Z"}},
    #   {"user_id"=>3, "question_id"=>3, "id"=>27, "created_at"=>"2014-02-06T21:42:03.387Z", "upped"=>nil, "updated_at"=>"2014-02-06T21:42:03.387Z", "question"=>{"updated_at"=>"2014-02-06T21:25:44.333Z", "id"=>3, "text"=>"Biography", "created_at"=>"2014-02-06T21:25:44.333Z"}},
    #   {"user_id"=>3, "question_id"=>4, "id"=>28, "created_at"=>"2014-02-06T21:42:03.390Z", "upped"=>nil, "updated_at"=>"2014-02-06T21:42:03.390Z", "question"=>{"updated_at"=>"2014-02-06T21:25:44.335Z", "id"=>4, "text"=>"Martin Scorsese", "created_at"=>"2014-02-06T21:25:44.335Z"}},
    #   {"user_id"=>3, "question_id"=>5, "id"=>33, "created_at"=>"2014-02-06T21:42:03.408Z", "upped"=>nil, "updated_at"=>"2014-02-06T21:42:03.408Z", "question"=>{"updated_at"=>"2014-02-06T21:25:44.337Z", "id"=>5, "text"=>"Kate Winslet", "created_at"=>"2014-02-06T21:25:44.337Z"}},
    #   {"user_id"=>3, "question_id"=>6, "id"=>34, "created_at"=>"2014-02-06T21:42:03.410Z", "upped"=>nil, "updated_at"=>"2014-02-06T21:42:03.410Z", "question"=>{"updated_at"=>"2014-02-06T21:25:44.339Z", "id"=>6, "text"=>"Romance", "created_at"=>"2014-02-06T21:25:44.339Z"}},
    #   {"user_id"=>3, "question_id"=>7, "id"=>35, "created_at"=>"2014-02-06T21:42:03.412Z", "upped"=>nil, "updated_at"=>"2014-02-06T21:42:03.412Z", "question"=>{"updated_at"=>"2014-02-06T21:25:44.342Z", "id"=>7, "text"=>"90s", "created_at"=>"2014-02-06T21:25:44.342Z"}},
    #   {"user_id"=>3, "question_id"=>8, "id"=>36, "created_at"=>"2014-02-06T21:42:03.415Z", "upped"=>nil, "updated_at"=>"2014-02-06T21:42:03.415Z", "question"=>{"updated_at"=>"2014-02-06T21:25:44.344Z", "id"=>8, "text"=>"Academy Awards nominee", "created_at"=>"2014-02-06T21:25:44.344Z"}},
    #   {"user_id"=>3, "question_id"=>9, "id"=>30, "created_at"=>"2014-02-06T21:42:03.395Z", "upped"=>nil, "updated_at"=>"2014-02-06T21:42:03.395Z", "question"=>{"updated_at"=>"2014-02-06T21:25:44.346Z", "id"=>9, "text"=>"Comedy", "created_at"=>"2014-02-06T21:25:44.346Z"}},
    #   {"user_id"=>3, "question_id"=>10, "id"=>31, "created_at"=>"2014-02-06T21:42:03.397Z", "upped"=>nil, "updated_at"=>"2014-02-06T21:42:03.397Z", "question"=>{"updated_at"=>"2014-02-06T21:25:44.348Z", "id"=>10, "text"=>"Recent Release", "created_at"=>"2014-02-06T21:25:44.348Z"}}]
    
    viewController = self.viewControllerAtIndex(0)
    self.setViewControllers([viewController], direction: UIPageViewControllerNavigationDirectionForward, animated:true, completion: nil)
  end
  
  def preferredStatusBarStyle
    UIStatusBarStyleLightContent
  end
  
  def viewControllerAtIndex(index)
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
  
  def showDone
    viewController = DoneViewController.alloc.init
    self.presentViewController(viewController, animated:true, completion:nil)
  end
  
end