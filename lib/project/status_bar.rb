class StatusBar
	class << self
		def	hide(animated=false)
			UIApplication.sharedApplication.setStatusBarHidden(true,animated:animated)
		end
	end
end
