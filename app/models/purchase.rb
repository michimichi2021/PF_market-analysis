class Purchase < ApplicationRecord
  
  enum payment_method: {
  クレジットカード: 0,
  コンビニ払い: 1}
  
  belongs_to :user
  belongs_to :item
  
end
