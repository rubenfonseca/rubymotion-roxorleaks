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
    queue = Dispatch::Queue.new("com.0x82.bug")
    queue.async {
      NSLog "Outside block"
    }
  end
end
