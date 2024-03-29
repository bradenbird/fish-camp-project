# spec/factories/camps.rb
require "faker"

FactoryBot.define do
  factory :camp do |c|
    c.name { Faker::Name.last_name }
    c.association :session
  end
end
