module RapidMotionView

	#addui :button, :purple, title:"Attack roll", bottom:25+25, touch:Proc.new{App.alert("fssfd")}
	# addui :nav_button, nil, {on: :right, text: "Me", touch:Proc.new{
 #      App.delegate.instance_variable_get("@view_deck").toggleRightViewAnimated(true)
 #    }}

 #    addui :nav_button, nil, {on: :left, image: "icolines", touch:Proc.new{
 #      App.delegate.instance_variable_get("@view_deck").toggleLeftViewAnimated(true)
 #    }}
	def addui(args={})
    		kind=args[:kind]
    		if kind==:button
					addui_button(args)
    		elsif kind==:nav_button
    			addui_nav_button(args)
    		end
    	end
    	def addui_nav_button(args={})
    		kind=args[:kind]
    		css=args[:css]
    		if args[:image].nil?
	    		db = UIBarButtonItem.alloc.initWithTitle(args[:text], style: UIBarButtonItemStyleBordered,target:self, action:args[:action])
					db.styleClass = "#{css}-button"
					# db.on(:touch){
					# 	args[:touch].call
					# }
					if args[:on]== :right
	    			self.navigationItem.rightBarButtonItem = db
					else
	    			self.navigationItem.leftBarButtonItem = db
				  end
					db
				else
					img=args[:image].uiimage.scale_to([24,24])
					db=UIButton.custom
					db.setImage(img,forState:UIControlStateNormal)
					db.frame = CGRectMake(0.0, 0.0, img.size.width, img.size.height)


					db.on(:touch){
						db.on(:touch){
							args[:touch].call
						}
					}
					aBarButtonItem = UIBarButtonItem.alloc.initWithCustomView(db)


					self.navigationItem.send("#{args[:on].downcase}BarButtonItem=",aBarButtonItem)
				end
    	end
    	def addui_button(args={})
    		kind=args[:kind]
    		css=args[:css]
    		button = UIButton.custom
				button.frame = [[25,App.window.frame.height-43-10-63-args[:bottom]*58],[272,43]]
				button.setTitle(args[:title],forState:UIControlStateNormal)
				button.styleClass = "#{css}-button"
				button.on(:touch){
					args[:touch].call
				}
				view << button
				button
    	end
	def navigation_bar
		self.navigationItem.navigationBar
	end

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
  def textFieldDidEndEditing(t)
  	view.slide(:down, 200)
  end
  def textFieldDidBeginEditing(t)
  	view.slide(:up, 200)
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