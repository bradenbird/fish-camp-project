# spec/factories/applicants.rb
require 'faker'

FactoryBot.define do
  factory :applicant do |a|
    a.submission_id { Faker::Number.number(8) }
    a.uin { Faker::Number.number(9).to_s }
  end
end
