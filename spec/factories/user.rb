FactoryBot.define do
  factory:user do
    last_name { Faker::Lorem.characters(number: 5) }
    first_name { Faker::Lorem.characters(number: 5) }
    last_name_kana { Faker::Lorem.characters(number: 5) }
    first_name_kana { Faker::Lorem.characters(number: 5) }
    postal_code {Faker::Number.number(7)}
    address {Faker::Address}
    email { Faker::Internet.email }
  end
end