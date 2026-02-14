#! /usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'
require_relative 'counter'
require_relative 'us_background'

class Fortysixth < Counter
  include UsBackground

  # Using embedded JPEG approach since bitmap-to-vector tracing
  # produces poor quality results for complex insignia
  # TODO: Manually trace the 46th Infantry insignia to create proper vector paths
  #       - Shield outline with proper curves
  #       - Canton with Roman numeral X and crosses
  #       - Five-pointed star
  #       - Torch with flame details
  #       - Color layers: blue field (#003087), gold elements (#FFD700), white canton
  # TODO: Replace with proper vector art when available

  def forty_sixth_insignia(xml)
    # Embed the original JPG image
    # Source dimensions: 836x1042 px
    xml.image(
      'xlink:href': '../original/46_INF_RGT_DUI.jpg',
      x: '0',
      y: '0',
      width: '836',
      height: '1042',
      preserveAspectRatio: 'xMidYMid meet'
    )
  end

  def build_counter(xml)
    counter_background(xml)
    xml.g(transform: "translate(#{offset_x},#{offset_y})") do
      bounding_box(xml)
    end
    # Scale and position the insignia
    # Source JPG is 836x1042 px, target counter is 1024x1024
    # Scale to fit with margins: ~0.9 scale factor
    xml.g(transform: 'translate(100,0) scale(0.9)') do
      forty_sixth_insignia(xml)
    end
  end

  def to_svg
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.svg(
        xmlns: 'http://www.w3.org/2000/svg',
        'xmlns:xlink': 'http://www.w3.org/1999/xlink',
        width: counter_width,
        height: counter_height
      ) do
        build_counter(xml)
      end
    end
    builder.to_xml
  end
end

File.write('generated/fortysixth-counter.svg', Fortysixth.new.to_svg) if __FILE__ == $PROGRAM_NAME
