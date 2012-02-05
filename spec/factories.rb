require 'factory_girl'

Factory.define :word do |f|
  f.sequence(:id) { |n| "word#{n}"}
  f.value { |a| "#{a.id}domain"}
end