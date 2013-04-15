class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    MagicalRecord.setupCoreDataStack

    window.makeKeyAndVisible

    true
  end

  def applicationWillTerminate(application)
    MagicalRecord.cleanUp
  end

  def window
    @window ||= begin
      window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
      window.rootViewController = MainViewController.alloc.init
      window
    end
  end
end
