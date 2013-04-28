class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    window.makeKeyAndVisible

    true
  end

  def window
    @window ||= begin
      window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
      window.rootViewController = MainViewController.alloc.init
      window
    end
  end
end
