
class UIViewController
    
    
    def frame
        view.frame
    end
    def set_background(uicolor)
        self.bcolor = uicolor
    end
    def bcolor=(uicolor)
        self.view.backgroundColor = uicolor
    end
    def shake(args={})
        self.view.shake(args)
    end
    def zoom(s)
        self.view.zoom(s)
    end


    def to_next_view(nav,ctrk)
        push_transition(nav,ctrk,UIViewAnimationOptionTransitionCurlUp)
    end
    def to_prior_view(nav,ctrk)
        push_transition(nav,ctrk,UIViewAnimationOptionTransitionCurlDown)
    end
    def push_curl_up(nav,ctrk)
        push_transition(nav,ctrk,UIViewAnimationOptionTransitionCurlUp)
    end
    def push_curl_down(nav,ctrk)
        push_transition(nav,ctrk,UIViewAnimationOptionTransitionCurlDown)
    end
    def push_cross_dissolve(nav,ctrk)
        push_transition(nav,ctrk,UIViewAnimationOptionTransitionCrossDissolve)
    end
    def push_transition(nav,ctrk,trans=UIViewAnimationOptionTransitionCurlUp)
        nav.addChildViewController(ctrk)
        UIView.transitionFromView(nav.childViewControllers[nav.childViewControllers.length-2].view, toView:nav.childViewControllers[nav.childViewControllers.length-1].view, duration:0.75, options:trans,completion:Proc.new{|finished|})
    end
    def push_move_in(nav,ctrk)
        push_catransition nav, ctrk, KCATransitionMoveIn, KCATransitionFromRight
    end
    def push_move_out(nav,ctrk)
        push_catransition nav, ctrk, KCATransitionMoveIn, KCATransitionFromLeft
    end
    def push_reveal(nav,ctrk)
        push_catransition nav, ctrk, KCATransitionReveal, KCATransitionFromRight
    end
    def push_reveal_back(nav,ctrk)
        push_catransition nav, ctrk, KCATransitionReveal, KCATransitionFromLeft
    end
    def push_catransition(nav,ctrk,trans,subt)
        transition = CATransition.animation
        transition.timingFunction = CAMediaTimingFunction.functionWithName(KCAMediaTimingFunctionEaseInEaseOut)
        transition.duration = 0.4
        transition.type = trans #Push Reveal
        transition.subtype = subt
        nav.view.layer.removeAllAnimations
        nav.view.layer.addAnimation(transition, forKey:KCATransition)
        nav.pushViewController(ctrk, animated:false)
    end
end



