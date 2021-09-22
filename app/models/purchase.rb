class Purchase < ApplicationRecord
  
  enum payment_method: {
  クレジットカード: 0,
  コンビニ払い: 1}
  
  belongs_to :user
  belongs_to :item
  
  validates :postal_code, format: {with: /\A\d{3}[-]\d{4}$|^\d{3}[-]\d{2}$|^\d{3}$|^\d{5}$|^\d{7}\z/}  
  validates :address, presence: true 
  validates :name, presence: true
end
