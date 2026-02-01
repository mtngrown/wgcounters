# frozen_string_literal: true

require_relative 'background_fill'

# Background color for North Vietnamese aircraft counters
module NvBackground
  include BackgroundFill

  def color
    'rgb(253,191,191)' # Light red color for NV counters
  end
end
