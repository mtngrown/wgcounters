# frozen_string_literal: true

RSpec.describe WGCounters::Fortysixth do
  describe '#to_svg' do
    let(:doc) { parse_svg(described_class.new.to_svg) }

    it 'produces an SVG with counter dimensions' do
      expect(doc).to have_svg_root(width: 1024, height: 1024)
    end

    it 'has OG-107 olive drab background' do
      expect(doc).to have_rect(fill: 'rgb(106,92,64)')
    end

    it 'declares the xlink namespace' do
      svg = doc.at_css('svg')
      expect(svg.namespaces).to include('xmlns:xlink' => 'http://www.w3.org/1999/xlink')
    end

    it 'embeds the insignia as an image element' do
      image = doc.at_css('image')
      expect(image).not_to be_nil
    end

    it 'references the correct JPG source' do
      image = doc.at_css('image')
      expect(image['xlink:href']).to eq('../original/46_INF_RGT_DUI.jpg')
    end

    it 'has no path elements (uses embedded image)' do
      expect(doc).to have_path_count(0)
    end

    it 'applies insignia transform' do
      groups = doc.css('g[transform]')
      transforms = groups.map { |g| g['transform'] }
      expect(transforms).to include('translate(100,0) scale(0.9)')
    end
  end

  describe '.counter_sheet_svg' do
    let(:doc) { parse_svg(described_class.counter_sheet_svg) }

    it 'produces an SVG at sheet dimensions' do
      expect(doc).to have_svg_root(width: 1000, height: 800)
    end

    it 'declares the xlink namespace' do
      svg = doc.at_css('svg')
      expect(svg.namespaces).to include('xmlns:xlink' => 'http://www.w3.org/1999/xlink')
    end

    it 'has a global scale(0.5) group' do
      group = doc.at_css("g[transform='scale(0.5)']")
      expect(group).not_to be_nil
    end

    it 'renders 80 counters' do
      rects = doc.css("rect[width='1024']")
      expect(rects.length).to eq(80)
    end
  end
end
