# spec/factories/sessions.rb
require "faker"

FactoryBot.define do
  factory :session do |s|
    s.name { ("A".."G").to_a.sample }
    s.year { (2018..2020).to_a.sample }
    s.start_date { Faker::Date.backward(30) }
    s.end_date { Faker::Date.forward(30) }
  end
end
