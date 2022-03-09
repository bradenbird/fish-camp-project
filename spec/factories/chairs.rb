# spec/factories/chairs.rb
require "faker"

FactoryBot.define do
  factory :chair do |c|
    c.association :user
    c.association :camp
  end
end
