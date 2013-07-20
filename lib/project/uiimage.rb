class Symbol
    def img
        self.uiimage
    end
    def imgv
        self.uiimage.uiimageview
    end
end
class String
    def img
        self.uiimage
    end
    def imgv
        self.uiimage.uiimageview
    end
end
class UIImage
    def iview
        self.uiimageview
    end
    def blur(options={})
        filter_name = 'CIGaussianBlur'
        filter_options = {
          inputRadius: options[:radius] || 6
        }

        cg_input_image = CIImage.alloc.initWithImage(self)
        filter = CIFilter.filterWithName(filter_name)
        raise Exception.new("Filter not found: #{filter_name}") unless filter



        filter.setDefaults
        filter.setValue(cg_input_image, forKey:'inputImage')
        filter_options.each_pair do |key, value|
          filter.setValue(value, forKey:key)
        end
        output = filter.valueForKey('outputImage')

        context = CIContext.contextWithOptions(nil)
        cg_output_image = context.createCGImage(output, fromRect:output.extent)
        output_image = UIImage.imageWithCGImage(cg_output_image, scale:self.scale, orientation:self.imageOrientation)

        return output_image
    end


    def burn(options={})
        filter_name = 'CIColorBurnBlendMode'
        filter_options = {
          
        }

        cg_input_image = CIImage.alloc.initWithImage(self)
        filter = CIFilter.filterWithName(filter_name)
        raise Exception.new("Filter not found: #{filter_name}") unless filter



        filter.setDefaults
        filter.setValue(cg_input_image, forKey:'inputImage')
        filter_options.each_pair do |key, value|
          filter.setValue(value, forKey:key)
        end
        output = filter.valueForKey('outputImage')

        context = CIContext.contextWithOptions(nil)
        cg_output_image = context.createCGImage(output, fromRect:output.extent)
        output_image = UIImage.imageWithCGImage(cg_output_image, scale:self.scale, orientation:self.imageOrientation)

        return output_image
    end
    def dodge(options={})
        filter_name = 'CIColorDodgeBlendMode'
        filter_options = {
          
        }

        cg_input_image = CIImage.alloc.initWithImage(self)
        filter = CIFilter.filterWithName(filter_name)
        raise Exception.new("Filter not found: #{filter_name}") unless filter



        filter.setDefaults
        filter.setValue(cg_input_image, forKey:'inputImage')
        filter_options.each_pair do |key, value|
          filter.setValue(value, forKey:key)
        end
        output = filter.valueForKey('outputImage')

        context = CIContext.contextWithOptions(nil)
        cg_output_image = context.createCGImage(output, fromRect:output.extent)
        output_image = UIImage.imageWithCGImage(cg_output_image, scale:self.scale, orientation:self.imageOrientation)

        return output_image
    end

    def halftone(options={})
        filter_name = 'CICMYKHalftone'
        filter_options = {
          inputWidth: options[:width] || 6
        }

        cg_input_image = CIImage.alloc.initWithImage(self)
        filter = CIFilter.filterWithName(filter_name)
        raise Exception.new("Filter not found: #{filter_name}") unless filter



        filter.setDefaults
        filter.setValue(cg_input_image, forKey:'inputImage')
        filter_options.each_pair do |key, value|
          filter.setValue(value, forKey:key)
        end
        output = filter.valueForKey('outputImage')

        context = CIContext.contextWithOptions(nil)
        cg_output_image = context.createCGImage(output, fromRect:output.extent)
        output_image = UIImage.imageWithCGImage(cg_output_image, scale:self.scale, orientation:self.imageOrientation)

        return output_image
    end
end
class UIView
    def img
        self.uiimage
    end
end





# class UILabel
#     def format(args={})
#         pad = args[:pad] || 10
#         container_width = args[:container_width]
#         af = args[:font] || App::FONT
#         col = args[:color] || :black.uicolor
#         sz = args[:size] || 18
#         self.setFont(UIFont.fontWithName(af, size:sz))
#         self.frame = self.frame.tap{|x|x.width=container_width-2*pad;x.left(pad)}
#         self.setColor col
#     end
# end