class Purchase < ApplicationRecord
  
  enum payment_method: {
  クレジットカード: 0,
  コンビニ払い: 1}
  
  belongs_to :user
  belongs_to :item
  
  validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/} 
  validates :address, presence: true 
  validates :name, presence: true
end
