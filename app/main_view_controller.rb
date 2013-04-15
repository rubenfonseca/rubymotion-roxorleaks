class MainViewController < UIViewController
  def viewDidLoad
    super

    button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    button.frame = [[10, 10], [100, 100]]
    button.setTitle "Spawn", forState:UIControlStateNormal
    button.addTarget self, action:"spawn", forControlEvents:UIControlEventTouchUpInside
    view.addSubview button
  end

  def spawn
    MagicalRecord.saveWithBlock lambda { |context|
      NSLog "Inside block"
    }, completion: lambda { |success, error|
      NSLog "Completed!"
    }
  end
end
