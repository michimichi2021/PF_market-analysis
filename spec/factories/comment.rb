FactoryBot.define do
  factory:comment do
    comment { Faker::Lorem.characters(number: 10) }
    association :user
    association :item
  end
end