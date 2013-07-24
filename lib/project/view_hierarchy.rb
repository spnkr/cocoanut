

class Frame
    def make()
        
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




class UIView
    class << self
        def make(args={}, &block)
            frame = args[:frame]
            units = args[:units] || :pixels
            if units== :percents
                frame[2] = frame[2] * Window.win.width
                frame[3] = frame[3] * Window.win.height
            elsif !args[:nowrap]
                frame[0] = Window.win.width+frame[0] if frame[0] < 0
                frame[1] = Window.win.height+frame[1] if frame[1] < 0
            end
            f=frame
            UIView.alloc.initWithFrame([[f[0],f[1]],[f[2],f[3]]]).tap do |u|
                back = args[:back]
                if back.nil?
                    u.bcolor = :clear.uicolor
                else
                    u.bcolor = back.uicolor
                end
                args[:join].tap{|q|if !q.nil?;q.paste(u);end}
                args[:tap].tap{|q|
                    if !q.nil?
                        u.when_tapped do
                            q.call
                        end
                    end
                }
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