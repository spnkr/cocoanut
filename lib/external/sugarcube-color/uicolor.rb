class UIColor

  def uicolor(alpha=nil)
    if alpha
      self.colorWithAlphaComponent(alpha.to_f)
    else
      self
    end
  end

  def cgcolor
    self.CGColor
  end

  # blends two colors by averaging the RGB and alpha components.
  # @example
  #     :white.uicolor + :black.uicolor == :gray.uicolor
  def +(color)
    mix_with(color.uicolor, 0.5)
  end

  # blends two colors by adding the colors, with an upper maximum of 255.
  # Adding white to any color will create white, adding black will do nothing.
  # Also takes transparency into account; adding a transparent color has no
  # effect, adding an opaque color has the most effect.
  # @example
  #     :red.uicolor << :blue.uicolor == '#ff00ff'.uicolor (:magenta)
  #     :red.uicolor << :blue.uicolor(0.5) == '#ff0080'.uicolor (pinkish)
  def <<(color)
    r = [1.0, color.red * color.alpha + self.red].min
    g = [1.0, color.green * color.alpha + self.green].min
    b = [1.0, color.blue * color.alpha + self.blue].min
    a = self.alpha
    UIColor.colorWithRed(r, green:g, blue:b, alpha:a)
  end

  # a more generic color mixing method.  mixes two colors, but a second
  # parameter determines how much of each.  0.5 means equal parts, 0.0 means use
  # all of the first, and 1.0 means use all of the second
  def mix_with(color, amount)
    color = color.uicolor

    # make amount between 0 and 1
    amount = [[0, amount].max, 1].min
    # start with precise amounts: 0, 0.5, and 1.
    if amount == 0 && self.alpha == color.alpha
      self
    elsif amount == 1 && self.alpha == color.alpha
      color
    elsif amount == 0.5 && self.alpha == color.alpha
      r = (self.red + color.red) / 2
      g = (self.green + color.green) / 2
      b = (self.blue + color.blue) / 2
      a = (self.alpha + color.alpha) / 2
      UIColor.colorWithRed(r, green:g, blue:b, alpha:a)
    else
      a = (color.alpha - self.alpha) * amount + self.alpha
      return UIColor.clearColor if a == 0

      color_red = color.red * color.alpha + self.red * (1 - color.alpha)
      self_red = self.red * self.alpha + color.red * (1 - self.alpha)
      color_green = color.green * color.alpha + self.green * (1 - color.alpha)
      self_green = self.green * self.alpha + color.green * (1 - self.alpha)
      color_blue = color.blue * color.alpha + self.blue * (1 - color.alpha)
      self_blue = self.blue * self.alpha + color.blue * (1 - self.alpha)

      r = (color_red - self_red) * amount + self_red
      g = (color_green - self_green) * amount + self_green
      b = (color_blue - self_blue) * amount + self_blue
      UIColor.colorWithRed(r, green:g, blue:b, alpha:a)
    end
  end

  # inverts the RGB channel.  keeps the alpha channel unchanged
  # @example
  #   :white.uicolor.invert == :black.uicolor
  def invert
    r = 1.0 - self.red
    g = 1.0 - self.green
    b = 1.0 - self.blue
    a = self.alpha
    UIColor.colorWithRed(r, green:g, blue:b, alpha:a)
  end

  def red
    _sugarcube_colors && _sugarcube_colors[:red]
  end

  def green
    _sugarcube_colors && _sugarcube_colors[:green]
  end

  def blue
    _sugarcube_colors && _sugarcube_colors[:blue]
  end

  def alpha
    _sugarcube_colors && _sugarcube_colors[:alpha]
  end

  # returns the components OR'd together, as 32 bit RGB integer.
  def to_i
    if self.red && self.green && self.blue
      red = (self.red * 255).round << 16
      green = (self.green * 255).round << 8
      blue = (self.blue * 255).round
      return red + green + blue
    else
      return nil
    end
  end

  # returns the components as an array of 32 bit RGB values
  def to_a
    if self.red && self.green && self.blue
      red = (self.red * 255).round
      green = (self.green * 255).round
      blue = (self.blue * 255).round
      return [red, green, blue]
    else
      return nil
    end
  end

  def hex
    my_color = self.to_i
    if my_color
      return '#' + my_color.to_s(16).rjust(6, '0')
    else
      nil
    end
  end

  # returns the closest css name
  def css_name
    my_color = self.to_i
    css_name = nil
    Symbol.css_colors.each do |color, hex|
      if hex == my_color
        css_name = color
        break
      end
    end
    return css_name
  end

  def system_name
    system_color = nil
    without_alpha = self.uicolor(1)
    Symbol.uicolors.each do |color, method|
      if UIColor.send(method) == without_alpha
        system_color = method
        break
      end
    end
    Symbol.uicolors__deprecated.each do |old_name, new_name|
      method = Symbol.uicolors[new_name]
      if UIColor.send(method) == without_alpha
        message = "The symbol #{old_name.inspect} has been deprecated in favor of #{new_name.inspect}"
        if defined?(SugarCube::Legacy)
          SugarCube::Legacy.log(message)
        else
          NSLog(message)
        end

        system_color = method
        break
      end
    end
    return system_color
  end

private
  def _sugarcube_color_compare(c1, c2)
    return (c1.red - c2.red).abs + (c1.green - c2.green).abs + (c1.blue - c2.blue).abs
  end

  def _sugarcube_colors
    @color ||= begin
      red = Pointer.new(:float)
      green = Pointer.new(:float)
      blue = Pointer.new(:float)
      white = Pointer.new(:float)
      alpha = Pointer.new(:float)
      if self.getRed(red, green:green, blue:blue, alpha:alpha)
        {
          red: red[0],
          green: green[0],
          blue: blue[0],
          alpha: alpha[0],
        }
      elsif self.getWhite(white, alpha:alpha)
        {
          red: white[0],
          green: white[0],
          blue: white[0],
          alpha: alpha[0],
        }
      else
        nil
      end
    end
  end

end
