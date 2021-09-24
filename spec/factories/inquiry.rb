FactoryBot.define do
  factory :inquiry do
    name { Faker::Lorem.characters(number: 5) }
    email { Faker::Internet.email }
  end
end
