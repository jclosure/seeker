require 'rubygems'
require 'rake'
require 'echoe'


Echoe.new('seeker', '0.1.1') do |p|
  p.description   = "Rapid lookup of bulk list content using network content and services"
  p.url           = "http://github.com/jclosure/seeker"
  p.author        = "Joel Holder"
  p.email         = "jclosure@gmail.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = ['rspec', 'echoe']
  p.runtime_dependencies << 'whois'
  p.runtime_dependencies << 'activerecord'
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }


require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new('spec')
task :default => :spec
