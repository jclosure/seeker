require 'rubygems'
require 'rake'
require 'echoe'
require 'rspec/core/rake_task'

Echoe.new('seeker', '0.1.0') do |p|
  p.description   = "Rapid lookup of bulk list content using network content and services"
  p.url           = "http://github.com/jclosure/seeker"
  p.author        = "Joel Holder"
  p.email         = "jclosure@gmail.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = ['rspec']
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }

RSpec::Core::RakeTask.new('spec')
task :default => :spec
