class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image

  def active_for_authentication?
    super && (self.is_deleted == false)
  end
  
  has_many :items,dependent: :destroy
  
end
