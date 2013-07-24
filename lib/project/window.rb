
class Window
    def self.window
        (UIApplication.sharedApplication.keyWindow || UIApplication.sharedApplication.windows[0])
    end
    def self.win
        self.window
    end
end
