require 'whois'
require './retryable'


class Seeker
  
  attr_accessor :file, :outfile
  
  def initialize 
    @client = Whois::Client.new(:timeout => 5)
  end
  
  def work_file(in_file_name, out_file_name, ext)
    @file = open(in_file_name)
    @outfile = open(out_file_name, 'w')
    while line = @file.gets
      domain_names = yield line, ext
      domain_names.each do | domain_name |
        begin
          retryable(:tries => 1, :on => StandardError) do
              self.probe_availability domain_name
          end
        rescue => e
          #puts e.backtrace
        end
      end
    end
  ensure
    @file.close if @file
    @outfile.close if @outfile
  end
  
  def probe_availability domain_name
    begin
      puts 'probing: ' + domain_name
      if (r = @client.query(domain_name))
        if (r.available?)
          puts 'available: ' + domain_name
          @outfile.puts domain_name
          @outfile.flush
        end
      end
    rescue => e
      puts e.message
      raise e
    end
  end
  
end