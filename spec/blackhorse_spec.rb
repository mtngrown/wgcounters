# frozen_string_literal: true

RSpec.describe WGCounters::Blackhorse do
  describe '#to_svg' do
    let(:doc) { parse_svg(described_class.new.to_svg) }

    it 'produces an SVG with counter dimensions' do
      expect(doc).to have_svg_root(width: 1024, height: 1024)
    end

    it 'has OG-107 olive drab background' do
      expect(doc).to have_rect(fill: 'rgb(106,92,64)')
    end

    it 'renders 4 insignia paths' do
      expect(doc).to have_path_count(4)
    end

    it 'includes the black outer shield' do
      paths = doc.css('path')
      fills = paths.map { |p| p['fill'] }
      expect(fills).to include('#000000')
    end

    it 'includes the white inner shield' do
      paths = doc.css('path')
      fills = paths.map { |p| p['fill'] }
      expect(fills).to include('#ffffff')
    end

    it 'includes the red diagonal stripe' do
      paths = doc.css('path')
      fills = paths.map { |p| p['fill'] }
      expect(fills).to include('#9f0f0f')
    end

    it 'applies insignia transform' do
      groups = doc.css('g[transform]')
      transforms = groups.map { |g| g['transform'] }
      expect(transforms).to include('translate(277,207) scale(2.0)')
    end
  end

  describe '.counter_sheet_svg' do
    let(:doc) { parse_svg(described_class.counter_sheet_svg) }

    it 'produces an SVG at sheet dimensions' do
      expect(doc).to have_svg_root(width: 1000, height: 800)
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
