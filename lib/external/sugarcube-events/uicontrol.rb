# Additions to UIControl to support jQuery-style `on` and `off` methods.
class UIControl

  # Add event handlers to UIControls.  See symbol.rb for the uicontrolevent
  # constant aliases.
  #
  # @example
  #   button = UIButton.alloc.initWithFrame([0, 0, 10, 10])
  #   button.on(:touch) { my_code }
  #   button.on(:touch_up_outside, :touch_cancel) { my_code }
  #   # up to two arguments can be passed in
  #   button.on(:touch) { |sender,touch_event| my_code }
  def on(*events, &block)
    handler = SugarCube::UIControlCallbackHelper.new
    handler.callback = block

    events.each do |event|
      event = event.uicontrolevent if event.respond_to?(:uicontrolevent)

      sugarcube_callbacks[event].push(handler)
      addTarget(handler, action:'call:event:', forControlEvents:event)
    end

    self
  end

  # Removes all events that were bound with `on`.  See symbol.rb for the
  # uicontrolevent constant aliases.
  #
  # @example
  #   button.off(:touch)
  #   button.off(:touch_up_outside, :touch_cancel)
  #   button.off  # all events
  def off(*events)
    if events.length == 0
      events = sugarcube_callbacks.keys
    end

    events.each do |event|
      event = event.uicontrolevent if event.respond_to?(:uicontrolevent)

      sugarcube_callbacks[event].each do |handler|
        self.removeTarget(handler, action:'call:event:', forControlEvents:event)
      end
      sugarcube_callbacks.delete(event)
    end
    self
  end

  # Useful during testing, or to simulate a button press.
  #
  # @example
  #   button.trigger(:touch)
  #   button.trigger(:touch_drag_outside, :touch_drag_exits)
  def trigger(*events)
    event_mask = 0
    events.each do |event|
      event = event.uicontrolevent if event.respond_to?(:uicontrolevent)
      event_mask |= event
    end
    sendActionsForControlEvents(event_mask)
  end

private
  # event blocks need to be retained, and the addTarget method explicitly does
  # *not* retain `target`.  This makes sure that callbacks are retained by
  # pushing the block onto a stack.
  def sugarcube_callbacks
    @sugarcube_callbacks ||= Hash.new { |hash, key| hash[key] = [] }
  end

end


module SugarCube
  class UIControlCallbackHelper
    attr_accessor :callback

    def call(sender, event:event)
      case callback.arity
      when 0
        callback.call
      when 1
        callback.call(sender)
      else
        callback.call(sender, event)
      end
    end
  end
end
