FactoryBot.define do
  factory :item do
    name { Faker::Lorem.characters(number: 10) }
    introduction { Faker::Lorem.characters(number: 20) }
    shipping_fee { Faker::Lorem.characters(number: 10) }
    shipping_method { Faker::Lorem.characters(number: 10) }
    shipping_area { Faker::Lorem.characters(number: 4) }
    preparation_day { Faker::Number }
    price { 1000 }
    association :user
    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('spec', 'factories', 'images', 'no_image.jpeg')), filename: 'no_image.jpeg', content_type: 'image/jpeg')
    end

    after(:create) do |item|
      create_list(:tag, 1, item: item, genre: create(:genre))
    end
  end
end
