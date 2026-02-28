# frozen_string_literal: true

module WGCounters
  # Abstract module for background fill color
  module BackgroundFill
    def color
      raise NotImplementedError, "#{self.class} must implement abstract method 'color'"
    end
  end
end
