# frozen_string_literal: true

RSpec.describe WGCounters::Counter do
  # Counter is abstract; create a test subclass with UsBackground
  let(:test_class) do
    Class.new(described_class) { include WGCounters::UsBackground }
  end
  let(:counter) { test_class.new }

  describe 'dimensions' do
    it 'has standard counter width' do
      expect(counter.counter_width).to eq(1024)
    end

    it 'has standard counter height' do
      expect(counter.counter_height).to eq(1024)
    end
  end

  describe 'offsets' do
    it 'returns x offset' do
      expect(counter.offset_x).to eq(-80)
    end

    it 'calculates y offset from counter and bounding box heights' do
      expect(counter.offset_y).to eq((1024 - 628) / 2)
    end
  end

  describe '#counter_background' do
    let(:svg) do
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.svg { counter.counter_background(xml) }
      end
      parse_svg(builder.to_xml)
    end

    it 'renders a rect with the fill color' do
      rect = svg.at_css('rect')
      expect(rect['fill']).to eq('rgb(106,92,64)')
    end

    it 'renders at full counter dimensions' do
      rect = svg.at_css('rect')
      expect(rect['width']).to eq('1024')
      expect(rect['height']).to eq('1024')
    end

    it 'has correct stroke attributes' do
      rect = svg.at_css('rect')
      expect(rect['stroke']).to eq('black')
      expect(rect['stroke-width']).to eq('1')
    end
  end

  describe '#bounding_box' do
    let(:svg) do
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.svg { counter.bounding_box(xml) }
      end
      parse_svg(builder.to_xml)
    end

    it 'renders a rect with expected dimensions' do
      rect = svg.at_css('rect')
      expect(rect['width']).to eq('728')
      expect(rect['height']).to eq('628')
    end
  end

  describe '#fill_color' do
    it 'builds rgb string from gray_index' do
      expect(counter.fill_color).to eq('rgb(90,90,90)')
    end
  end

  describe 'text positioning' do
    let(:svg) do
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.svg do
          counter.top_left_value(xml, '3')
          counter.top_right_value(xml, '5')
        end
      end
      parse_svg(builder.to_xml)
    end

    it 'places top_left_value at x=200' do
      text = svg.css('text').first
      expect(text['x']).to eq('200')
      expect(text.text).to eq('3')
    end

    it 'places top_right_value at x=800' do
      text = svg.css('text').last
      expect(text['x']).to eq('800')
      expect(text.text).to eq('5')
    end

    it 'uses font_size for text elements' do
      svg.css('text').each do |text|
        expect(text['font-size']).to eq('300px')
      end
    end
  end

  describe '#initialize' do
    it 'defaults fill to the background module color' do
      expect(counter.instance_variable_get(:@fill)).to eq('rgb(106,92,64)')
    end

    it 'accepts an explicit fill override' do
      custom = test_class.new('red')
      expect(custom.instance_variable_get(:@fill)).to eq('red')
    end
  end
end

RSpec.describe WGCounters::BackgroundFill do
  it 'raises NotImplementedError when color is not implemented' do
    klass = Class.new(WGCounters::Counter) { include WGCounters::BackgroundFill }
    expect { klass.new }.to raise_error(NotImplementedError, /must implement abstract method 'color'/)
  end
end

RSpec.describe WGCounters::UsBackground do
  let(:counter) do
    Class.new(WGCounters::Counter) { include WGCounters::UsBackground }.new
  end

  it 'returns OG-107 olive drab' do
    expect(counter.color).to eq('rgb(106,92,64)')
  end
end

RSpec.describe WGCounters::NvBackground do
  let(:counter) do
    Class.new(WGCounters::Counter) { include WGCounters::NvBackground }.new
  end

  it 'returns light red' do
    expect(counter.color).to eq('rgb(253,191,191)')
  end
end
