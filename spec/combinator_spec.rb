require 'spec_helper'
require 'factories.rb'
require 'domain_name'

describe Combinator, "Combinators behavior" do

  before :all do
    @list = (1..5).collect {Factory(:domainname)}
    @combinator = Combinator.new
  end

  after :all do

  end

  it "combines names from list into randomized set" do
    combos = @combinator.generate_combos @list.map { |domain_name| domain_name.word }
    p combos
  end
end