require 'faker'

FactoryBot.define do
  sequence(:user_name) { |n| "User ##{n}" }
  sequence(:user_email) { |n| "user#{n}.email@domain" }

  factory :user do |u|
    u.name { generate :user_name }
    u.email { generate :user_email }
    u.google_uid { Faker::Crypto.sha1 }
    u.role { "Chair" }
  end

  factory :faker_user, class: User do |u|
    u.google_uid{ Faker::Crypto.sha1 }
    u.name{ Faker::Name.name }
    u.email{ Faker::Internet.email }
    u.role{ "Chair" }
  end
end
