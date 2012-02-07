require 'whois'
require 'active_record'

begin
  require 'retryable'
rescue LoadError
  puts 'unable to load retryable from gem cache.  falling back to local filesystem.'
  retryable_path = File.expand_path('retryable.rb', File.dirname(__FILE__))
  require retryable_path
end


class Seeker

  attr_accessor :file, :outfile

  def initialize
    @client = Whois::Client.new(:timeout => 5)
    self.set_out
  end

  def set_out
    @out = $stdout
    @out = yield if block_given?
  end

  def work_file(*args)
    begin
      @file = open(args[0])
      @out = open(args[1], 'w')
      while line = @file.gets
        if block_given?
          yield(line)
        else
          #assume args[2] is the split delimiter and args[3] is the tld (eg: .com)
          self.work_list(line.split(args[2])) { |word| word + (args[3] || ' ')}
        end
      end
    ensure
      @file.close if @file
      @out.close if @outfile
      self.set_out
    end
  end

  def work_list(list)
    list.each do | domain_name |
      domain_name = yield(domain_name) if block_given?
      begin
        retryable(:tries => 1, :on => StandardError) do
          self.probe_availability domain_name
        end
      rescue => e
        #puts e.backtrace
      end
    end
  end

  def probe_availability domain_name
    @out = yield if block_given?
    begin
      puts 'probing: ' + domain_name.to_s
      if (r = @client.query(domain_name.to_s.strip))
        if (r.available?)
          puts 'available: ' + domain_name.to_s
          @out.puts domain_name.to_s.strip
          @out.flush
        end
      end
    rescue => e
      puts e.message
      raise e
    end
  end

end

# class ActiveRecord::Base
#   include Seeker #see: http://railscasts.com/episodes/135-making-a-gem
# end
