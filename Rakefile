require "rake"
require "rspec/core/rake_task"
require 'bundler/setup'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob("spec/**/*_spec.rb")
end
task default: :spec
