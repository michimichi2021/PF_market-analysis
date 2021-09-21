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
  
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/}
  validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/}
  validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}  
  validates :address, presence: true 
  validates :telephone_number, numericality: { only_integer: true}
  validates :password,:password_confirmation,length:{minimum:6},format:{with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{7,}/}
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, {presence: true,format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }}

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
