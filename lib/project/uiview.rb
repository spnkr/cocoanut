
class UIView
    def shrink(args={})
        scale=args[:scale] || 0.1
        scale=args[:alpha] || 0
        zoom_out_to scale:scale, alpha:alpha
    end
    def explode
        zoom_out_to scale:4, alpha:0
    end
    def restore
        zoom_out_to scale:1, alpha:1
    end
    def zoom!(args={})
        zoom_out_to args
    end
    def zoom_out_to(args={})
        vw = args[:view] || self
        scale=args[:scale] || 1.0
        alpha=args[:alpha] || 1.0
        duration=args[:duration] || 0.5
        UIView.animateWithDuration(duration, delay:0, options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut, animations: lambda{vw.transform = CGAffineTransform.make(scale: scale); vw.alpha=alpha}, completion:nil)
    end
    def perspective(args={})
        
        vw = args[:view] || self
        scale=args[:scale] || 1.0
        alpha=args[:alpha] || 1.0
        duration=args[:duration] || 0.5
        p = args[:amount] || [0,0.0004]
        UIView.animateWithDuration(duration, delay:0, options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut, animations: lambda{vw.layer.transform = CATransform3D.identity.perspective(p[0],p[1])}, completion:nil)
    end
    def perspective_and_grow(args={})

        
        vw = args[:view] || self
        scale=args[:scale] || 2.0
        alpha=args[:alpha] || 1.0
        duration=args[:duration] || 0.5
        p = args[:amount] || [0,0.0004]
        UIView.animateWithDuration(duration, delay:0, options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut, animations: lambda{vw.layer.transform = CATransform3D.identity.scale(scale).perspective(p[0],p[1])}, completion:nil)
    end
    def gradient(a,b=nil)
        if b.nil?
            b = a[1]
            a = a[0]
        end

        gradient = CAGradientLayer.layer
        gradient.frame = self.bounds
        gradient.colors = [a.uicolor.CGColor,b.uicolor.CGColor]
        self.layer.addSublayer(gradient) 
    end
    def gradient2(locs,colors)
        

        gradient = CAGradientLayer.layer
        gradient.frame = self.bounds
        gradient.colors = colors.map{|c|c.uicolor.CGColor}
        gradient.locations = locs
        self.layer.addSublayer(gradient) 
    end
    def appear
        fade_in(duration:0.1+rand,delay:(0.1+rand)/2,options:UIViewAnimationOptionCurveEaseIn,opacity:1.0)
    end
    def vanish
        fade_out(duration:0.1+rand,delay:(0.1+rand)/2,options:UIViewAnimationOptionCurveEaseOut,opacity:0.0)
    end

    def views
        subviews
    end
    def kill
        destroy
    end
    def destroy
        #dealloc?
        removeFromSuperview
    end
    def cut
        lift
    end
    def lift
        removeFromSuperview
    end
    def wiggle
        shake offset: 0.1, repeat: 2, duration: 0.5, keypath: 'transform.rotation'
    end
    def shake_up_down
        shake offset: 5, repeat: 4, duration: 0.78, keypath: 'transform.translation.y'
    end
    def shake_left_right
        shake #offset: 5, repeat: 4, duration: 0.78, keypath: 'transform.translation.x'
    end
    def bcolor=(uicolor)
        self.backgroundColor = uicolor
    end
    def tack(uiview)
        paste(uiview)
    end
    def join(uiview)
        paste(uiview)
    end
    def paste(uiview)
        self.addSubview(uiview)
        uiview
    end
    def inset!(ei=EdgeInsets(10))
        self.frame = self.frame.inset(ei)
    end
    def shadow!(args={})
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = args[:radius] || 5
        self.layer.shadowOffset = [0,0]
        self.layer.shadowColor = :black.uicolor.CGColor
        # self.layer.shouldRasterize = true
    end
    def round!(rad=5)
        self.layer.cornerRadius = rad
        self.layer.masksToBounds = true
    end
    def height
        frame.height
    end
    def width
        frame.width
    end
end
