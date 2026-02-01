# frozen_string_literal: true

# Abstract module for background fill color
module BackgroundFill
  def color
    raise NotImplementedError, "#{self.class} must implement abstract method 'color'"
  end
end
