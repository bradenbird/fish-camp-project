FactoryBot.define do
  factory :interview do |i|
    i.association :applicant
    i.association :chair
  end
end
