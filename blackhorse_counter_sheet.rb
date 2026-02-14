#! /usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'
require_relative 'blackhorse'

# 8 rows, 10 columns = 80 Blackhorse counters

def row(xml, row_number)
  (1..10).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{row_number * 200}) scale(0.2)") do
      Blackhorse.new.build_counter(xml)
    end
  end
end

def to_svg
  builder = Nokogiri::XML::Builder.new do |xml|
    xml.svg(xmlns: 'http://www.w3.org/2000/svg', width: '1000', height: '800') do
      xml.g(transform: 'scale(0.5)') do
        (0..7).each do |row_number|
          row(xml, row_number)
        end
      end
    end
  end
  builder.to_xml
end

File.write('generated/blackhorse-counter-sheet.svg', to_svg)
