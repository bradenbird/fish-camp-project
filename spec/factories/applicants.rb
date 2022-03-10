# spec/factories/applicants.rb
require "faker"

FactoryBot.define do
  factory :applicant do
    submission_id { Faker::Number.number(digits: 8) }
    uin { Faker::Number.number(digits: 9).to_s }

    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    last_4_uin { Faker::Number.number(digits: 4) }

    tamu_email { "#{first_name}.#{last_name}@tamu.edu" }
    other_email { Faker::Internet.safe_email }
    phone { Faker::PhoneNumber.phone_number }

    trait :with_interviews do
      after(:create) do |applicant, evaluator|
        create_list(:interview, 2, applicant: applicant)
        applicant.reload
      end
    end
  end
end
