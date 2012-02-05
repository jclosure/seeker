require 'factory_girl'


FactoryGirl.define do
  factory :domainname do
    initialize_with { Domainname.new((0...5).map{ ('a'..'z').to_a[rand(26)] }.join, 'com') { |word, tld| word + '.' + tld } }
  end
end

#build the following with
# @list = (1..5).collect { Factory(:word) }.map { |w| w.value }

# Factory.define :domainname do |f|
#   f.sequence(:id) { |n| "word#{n}"}
#   f.word { |my| (0...5).map{ ('a'..'z').to_a[rand(26)] }.join }
#   f.tld { |my| 'com' }
#   f.value { |my| "#{my.word}#{my.id}.#{my.tld}"}
# end
