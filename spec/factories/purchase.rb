FactoryBot.define do
  factory :purchase do
    postal_code { 1234567 }
    address { Faker::Address }
    name { Faker::Lorem.characters(number: 5) }
    association :user
    association :item
  end
end
