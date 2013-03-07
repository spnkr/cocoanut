module RapidMotion

	def add_button(args)
		style = args[:style] || :rounded

		b1=UIButton.send(style).setTitle(args[:title], forState:UIControlStateNormal)
		
		bottom=args[:bottom]
		if !bottom.nil?
			b1.frame = [[40, content_frame.height-20-(60*(1+bottom))], [view.frame.size.width - 40 * 2, 40]]
		else
			top = args[:top] || 0
			b1.frame = [[40, 60*(1+top)-20], [view.frame.size.width - 40 * 2, 40]]
		end
		
		
		b1.on(:touch){
			self.send(args[:action])
		}
		
		unless args[:css].nil?
			b1.styleId = args[:css]
		end

    add_element b1
		b1
	end
	def add_back_button(args={})
		add_image_button(args)
	end
	def add_image_button(args={})
		style = args[:style] || :custom
		b1=UIButton.send(style).setImage((args[:image] || "icoback").uiimage.scale_within([20,20]), forState:UIControlStateNormal)
		b1.frame = [[10, 10], [20,20]]
		# b1.styleId = 'backButton'
		
		b1.on(:touch){
			self.send(args[:action]|| :move_back)
		}
		
    add_element b1
    
	end
	def add_input(key,args={})
		
		bottom=args[:bottom]
		if !bottom.nil?
			frame = [[40, content_frame.height-20-(60*(1+bottom))], [view.frame.size.width - 40 * 2, 40]]
		else
			top = args[:top] || 0
			frame = [[40, 60*(1+top)-20], [view.frame.size.width - 40 * 2, 40]]
		end
		b1=UITextField.alloc.initWithFrame(frame)
		b1.placeholder=args[:placeholder]
		
		b1.on(:touch){
			self.send(args[:action])
		}
		b1.delegate = self
		b1.returnKeyType = UIReturnKeyDone
		
		b1.keyboardType = args[:keyboardType] unless args[:keyboardType].nil?

		b1.textColor = :black.uicolor
		b1.backgroundColor = :white.uicolor
		b1.autocorrectionType = UITextAutocorrectionTypeNo
		b1.autocapitalizationType = UITextAutocapitalizationTypeNone
		b1.textAlignment = UITextAlignmentLeft
		b1.borderStyle = UITextBorderStyleRoundedRect

		begin
			b1.frame = b1.subviews[1].frame.right(7).down(7)
		rescue
		end

		self.instance_variable_set "@#{key.to_s}".to_sym, b1
    add_element b1
    b1
	end

	def textFieldDidEndEditing(textField)
    textField.resignFirstResponder
  end
  def textFieldShouldReturn(textField)
    textField.resignFirstResponder;
    return 'YES'
  end
	def background_image(i)
		self.view.backgroundColor = "#{i}".uiimage.scale_within([view.frame.size.width,view.frame.size.height+1000]).uicolor
	end
	def background_color(i)
		self.view.backgroundColor = "#{i}".uicolor
	end

end