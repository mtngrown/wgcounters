# frozen_string_literal: true

module SVGHelpers
  def parse_svg(xml_string)
    Nokogiri::XML(xml_string)
  end
end

RSpec::Matchers.define :have_svg_root do |width: nil, height: nil|
  match do |doc|
    svg = doc.at_css('svg')
    return false unless svg
    return false if width && svg['width'] != width.to_s
    return false if height && svg['height'] != height.to_s

    true
  end

  failure_message do |doc|
    svg = doc.at_css('svg')
    if svg.nil?
      'expected document to have an <svg> root element, but none found'
    else
      "expected <svg> with width=#{width}, height=#{height}, " \
        "got width=#{svg['width']}, height=#{svg['height']}"
    end
  end
end

RSpec::Matchers.define :have_rect do |fill:|
  match do |doc|
    !doc.at_css("rect[fill='#{fill}']").nil?
  end

  failure_message do
    "expected a <rect> element with fill='#{fill}'"
  end
end

RSpec::Matchers.define :have_path_count do |expected|
  match do |doc|
    doc.css('path').length == expected
  end

  failure_message do |doc|
    "expected #{expected} <path> elements, got #{doc.css('path').length}"
  end
end

RSpec.configure do |config|
  config.include SVGHelpers
end
