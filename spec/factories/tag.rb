FactoryBot.define do
  factory :tag do
    association :genre
    association :item
  end
end
