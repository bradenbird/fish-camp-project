# spec/factories/users.rb
require 'faker'

FactoryBot.define do
  factory :user do |u|
    u.google_uid{ Faker::Crypto.sha1 }
    u.name{ Faker::Name.name }
    u.email{ Faker::Internet.email }
    u.role{ "Chair" }
  end
end
