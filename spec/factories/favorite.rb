FactoryBot.define do
  factory :favorite do
    association :user
    association :item
  end
end
