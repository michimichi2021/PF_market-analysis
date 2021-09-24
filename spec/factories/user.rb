FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    last_name { Faker::Lorem.characters(number: 5) }
    first_name { Faker::Lorem.characters(number: 5) }
    last_name_kana { person.last.katakana }
    first_name_kana { person.first.katakana }
    address { Faker::Address }
    email { Faker::Internet.email }
    telephone_number { "090654321" }
    password { "password" }
    postal_code { "1234567" }
  end
end
