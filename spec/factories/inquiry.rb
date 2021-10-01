FactoryBot.define do
  factory :inquiry do
    name { Faker::Lorem.characters(number: 5) }
    email { Faker::Internet.email }
    message { Faker::Lorem.characters(number: 5) }
  end
end
