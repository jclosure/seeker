require 'whois'
require 'active_support'
require 'active_record'

begin
  require 'retryable'
rescue LoadError
  puts 'unable to load retryable from gem cache.  falling back to local filesystem.'
  retryable_path = File.expand_path('retryable.rb', File.dirname(__FILE__))
  require retryable_path
end

#todo: move to own file
class Hash
  def reverse_merge(other_hash)
    other_hash.merge(self)
  end
  def reverse_merge!(other_hash)
    # right wins if there is no left
    merge!( other_hash ){|key,left,right| left }
  end
  def options_merge(options)
    self.to_options.reverse_merge options
  end
  def options_merge!(options)
    self.to_options!.reverse_merge! options
  end
end


class Seeker

  attr_accessor :file, :outfile, :options

  def initialize options = {}
    @options = options.options_merge :suffix => '.com',
                                     :delimeter => ' '
    @client = Whois::Client.new(:timeout => 5)
    self.set_out
  end

  def set_out
    @out = $stdout
    @out = yield if block_given?
  end

  def work_file(infile, outfile, suffix = nil, delimeter = nil)
    begin
      @file = open(infile)
      @out = open(outfile, 'w')
      while line = @file.gets
        if block_given?
          yield(line)
        else
          #assume args[2] is the split delimiter and args[3] is the tld (eg: .com)
          self.work_list(line.split(delimeter)) { |word| word + (suffix || @options[:suffix]) }
        end
      end
    ensure
      @file.close if @file
      @out.close if @outfile
      self.set_out
    end
  end

  def work_list(*list)
    list = list[0] if list[0].is_a? Array rescue list #handles when args are splatted
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
