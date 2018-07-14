# spec/factories/session_availabilities.rb

FactoryBot.define do
  factory :session_availability do |s|
    s.association :applicant
    s.association :session
  end
end
