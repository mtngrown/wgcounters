#! /usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'
require_relative 'counter'
require_relative 'us_background'

class Fortysixth < Counter
  include UsBackground

  # Main silhouette path from potrace (simplified for now - full path is very long)
  # TODO: Extract full path data from original/46_INF_RGT_DUI.svg
  # For now, we'll use a placeholder approach

  def forty_sixth_insignia(xml)
    # Read and render the traced SVG paths
    # For simplicity, embedding the SVG group directly
    doc = File.open('original/46_INF_RGT_DUI.svg') { |f| Nokogiri::XML(f) }

    # Extract all path elements from the source SVG
    doc.xpath('//xmlns:path').each do |path|
      xml.path(
        d: path['d'],
        fill: '#000000',  # Start with black silhouette
        style: 'fill-opacity:1;stroke:none'
      )
    end
  end

  def build_counter(xml)
    counter_background(xml)
    xml.g(transform: "translate(#{offset_x},#{offset_y})") do
      bounding_box(xml)
    end
    # Scale and position the insignia
    # Source is 1672x2084 pt, target counter is 1024x1024
    # Scale factor: ~0.4 to fit nicely
    xml.g(transform: 'translate(200,100) scale(0.04)') do
      forty_sixth_insignia(xml)
    end
  end

  def to_svg
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.svg(xmlns: 'http://www.w3.org/2000/svg', width: counter_width, height: counter_height) do
        build_counter(xml)
      end
    end
    builder.to_xml
  end
end

File.write('generated/fortysixth-counter.svg', Fortysixth.new.to_svg) if __FILE__ == $PROGRAM_NAME
