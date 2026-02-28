# frozen_string_literal: true

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc 'Generate all counters and sheets'
task :generate do
  sh 'ruby exe/generate_blackhorse'
  sh 'ruby exe/generate_first_cav'
  sh 'ruby exe/generate_fortysixth'
end

namespace :generate do
  desc 'Generate Blackhorse counter and sheet'
  task(:blackhorse) { sh 'ruby exe/generate_blackhorse' }

  desc 'Generate 1st Cav counter and sheet'
  task(:first_cav) { sh 'ruby exe/generate_first_cav' }

  desc 'Generate 46th Infantry counter and sheet'
  task(:fortysixth) { sh 'ruby exe/generate_fortysixth' }
end
