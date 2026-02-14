# frozen_string_literal: true

require_relative 'background_fill'

module UsBackground
  include BackgroundFill

  def color
    'rgb(106,92,64)'  # OG-107 olive drab (Vietnam War era)
  end
end
