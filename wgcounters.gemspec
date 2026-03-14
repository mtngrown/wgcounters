# frozen_string_literal: true

require_relative 'lib/wgcounters/version'

Gem::Specification.new do |spec|
  spec.name          = 'wgcounters'
  spec.version       = WGCounters::VERSION
  spec.authors       = ['Dave Doolin']
  spec.summary       = 'SVG counter generator for conflict simulation wargames'
  spec.description   = 'Generates SVG-based counters and counter sheets for ' \
                       'conflict simulation wargames, with focus on Vietnam War scenarios.'
  spec.homepage      = 'https://github.com/daviddoolin/wgcounters'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 4.0'

  spec.files         = Dir['lib/**/*.rb', 'exe/*']
  spec.bindir        = 'exe'
  spec.executables   = Dir['exe/*'].map { |f| File.basename(f) }

  spec.add_dependency 'nokogiri', '~> 1.19'

  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.75'
  spec.add_development_dependency 'rubocop-performance', '~> 1.25'
  spec.add_development_dependency 'rubocop-rake', '~> 0.7'
  spec.add_development_dependency 'rubocop-rspec', '~> 3.6'
  spec.add_development_dependency 'simplecov', '~> 0.22'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
