require 'spec_helper'
require 'factories.rb'


describe Seeker, "doing bulk checks for dns name availability" do

  before :all do
    @list = (1..5).collect {Factory(:domainname)}
    @seeker = Seeker.new
  end

  after :all do

  end

  it "takes an input file and writes an output file" do
    @seeker.work_file('./spec/testfile.txt', './spec/testfile.out.txt') do |line|
      words = line.downcase.chomp.split.map { |word| word.strip }
      @seeker.work_list(words) { |word| domain_name = word + '.com' }
    end
  end
  
  it "works with a list of string domain names" do
    @seeker.work_list ['foobar.com', 'monkeyass.org']
  end
  
  it "takes a list of string words allowing a block to build domain names" do
    @seeker.work_list(['foobar', 'monkeyass']) { |word| Domainname.new(word, 'com') { |word, tld| word + '.' + tld } } 
  end
  
  it "checks each word in the file for dns availability using the tld ext passed" do
    @seeker.work_list(@list)
  end
  
  
end
