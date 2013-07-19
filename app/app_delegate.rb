class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @w=UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds).tap do |w|
        w.makeKeyAndVisible
    end


    view = UIView.make(frame:[0,0,100,150], units: :pixels, back: :white.clr).tap do |v|
        Window.win.paste v
    end

    UIView.make(frame:[0,110,0.5,0.2], units: :percents, back: :pink.clr, join: Window.win)



    true
  end
end
