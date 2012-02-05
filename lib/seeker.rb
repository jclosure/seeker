require 'whois'
require 'retryable'
require 'domain_name'


class Seeker
  
  attr_accessor :file, :outfile
  
  def initialize 
    @client = Whois::Client.new(:timeout => 5)
    self.reset_out
  end
  
  def reset_out
    @out = $stdout
  end
  
  def work_file(in_file_name, out_file_name)
    @file = open(in_file_name)
    @out = open(out_file_name, 'w')
    while line = @file.gets
      yield(line)
    end
  ensure
    @file.close if @file
    @out.close if @outfile
    self.reset_out
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
    begin
      puts 'probing: ' + domain_name.to_s
      if (r = @client.query(domain_name.to_s))
        if (r.available?)
          puts 'available: ' + domain_name.to_s
          @out.puts domain_name.to_s
          @out.flush
        end
      end
    rescue => e
      puts e.message
      raise e
    end
  end
  
end