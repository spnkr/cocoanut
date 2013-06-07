class UILabel
	def inset_white(args={})
		self.color=:white.uicolor
		self.layer.shadowOpacity = 1.0
		self.layer.shadowRadius = 0
		self.layer.shadowOffset = [-1,-1]
		self.layer.shadowColor = :black.uicolor.CGColor
		self.setFont(UIFont.fontWithName("VAGRounded-Bold", size:(args[:size]||28)))
		self.layer.shadowColor = :black.uicolor(0.3).CGColor
		self
	end
	def embossed_white(args={})
		self.color=:white.uicolor
		self.layer.shadowOpacity = 1.0
		self.layer.shadowRadius = 0
		self.layer.shadowOffset = [1,1]
		self.layer.shadowColor = :black.uicolor.CGColor
		self.setFont(UIFont.fontWithName("VAGRounded-Bold", size:(args[:size]||28)))
		self.layer.shadowColor = :black.uicolor(0.3).CGColor
		self
	end
end