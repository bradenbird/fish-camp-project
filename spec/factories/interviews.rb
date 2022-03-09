FactoryBot.define do
  factory :interview do
    transcript1 { Faker::Lorem.paragraph }
    transcript2 { Faker::Lorem.paragraph }

    association :applicant
    association :chair
  end
end
