# spec/factories/session_availabilities.rb
require "faker"

FactoryBot.define do
  factory :session_availability do |s|
    s.association :applicant
    s.association :session
  end
end
