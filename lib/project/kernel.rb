module Kernel

  # Yield self -or- return self.
  #
  #   "a".ergo.upcase #=> "A"
  #   nil.ergo.foobar #=> nil
  #
  #   "a".ergo{ |o| o.upcase } #=> "A"
  #   nil.ergo{ |o| o.foobar } #=> nil
  #
  # This is like #tap, but #tap yields self and returns self,
  # where as #ergo yields self but returns the result.
  #
  # CREDIT: Daniel DeLorme
  def ergo(&b)
    if block_given?
      b.arity == 1 ? yield(self) : instance_eval(&b)
    else
      self
    end
  end

end