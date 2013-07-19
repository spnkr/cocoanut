module ViewHierarchy

end

class Symbol
    def clr
        self.uicolor
    end
    def 
        self.uicolor
    end
    # alias_method :clr, :uicolor
    # alias_method :color, :uicolor
    
end

class Frame
    def make()
        
    end
end

class UIView
    class << self
        def make(args={}, &block)
            frame = args[:frame]
            units = args[:units] || :percents
            if units== :percents
                frame[2] = frame[2] * Window.win.width
                frame[3] = frame[3] * Window.win.height
            end
            f=frame
            UIView.alloc.initWithFrame([[f[0],f[1]],[f[2],f[3]]]).tap do |u|
                back = args[:back]
                unless back.nil?
                    u.bcolor = back
                end
                args[:join].tap{|q|if !q.nil?;q.paste(u);end}
            end
        end
    end
    def paste(uiview)
        self.addSubview(uiview)
        uiview
    end
    def views
        subviews
    end
    def lift
        removeFromSuperview
    end
    def bcolor=(uicolor)
        self.backgroundColor = uicolor
    end
    def bcolor
        self.backgroundColor
    end
end

class UIViewController
    include ViewHierarchy
    def paste(uiview)
        self.view.paste(uiview)
        uiview
    end
    def views
        self.view.views
    end
end


class Window
    def self.window
        (UIApplication.sharedApplication.keyWindow || UIApplication.sharedApplication.windows[0])
    end
    def self.win
        self.window
    end
end

class UIWindow
    def method_name
        
    end
end

class DSFingerTipWindow

end
