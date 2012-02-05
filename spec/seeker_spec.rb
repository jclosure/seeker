require 'spec_helper'
require 'factories.rb'


describe Seeker, "doing bulk checks for dns name availability" do

  before :all do
    @list = (1..5).collect { Factory(:word) }.map { |w| w.value }
    @seeker = Seeker.new
  end

  after :all do

  end

  it "takes an input file and writes an output file" do
    @seeker.work_file('./spec/testfile.txt', 'testfile.out.txt') do |line|
      words = line.downcase.chomp.split.map { |word| word.strip }
      @seeker.work_list(words) { |word| domain_name = word + '.com' }
    end
  end
  
  
  it "checks each word in the file for dbs availability using the tld ext passed" do
    @seeker.work_list(@list) { |word| domain_name = word + '.com' }
  end
end
