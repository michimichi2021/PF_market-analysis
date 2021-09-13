class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :purchases,dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :items,dependent: :destroy
  
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :follower_user, through: :followed, source: :follower
  has_many :following_user, through: :followers, source: :followed
  
  
  def follow(user_id)
   followers.create(followed_id: user_id)
  end
  
  def unfollow(user_id)
   followers.find_by(followed_id: user_id).destroy
  end
  
  def following?(user)
   following_user.include?(user)
  end

  
 
  def self.search(word)
   @users = User.where("last_name LIKE?","%#{word}%")
  end

  has_one_attached :image

  def active_for_authentication?
    super && (self.is_deleted == false)
  end
  
 
  
end
