class Item < ApplicationRecord
  belongs_to :user

  has_many :tags, dependent: :destroy
  has_many :genres, through: :tags
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one :purchase, dependent: :destroy

  validates :name, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  has_one_attached :image
  validates :image, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'] }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def save_genre(save_genres)
    current_genres = genres.pluck(:name) unless genres.nil?
    old_genres = current_genres - save_genres
    new_genres = save_genres - current_genres

    old_genres.each do |old_name|
      genres.delete Genre.find_by(name: old_name)
    end

    new_genres.each do |new_name|
      new_item_genre = Genre.find_or_create_by(name: new_name)
      genres << new_item_genre
    end
  end

  def self.search(word)
    where("name LIKE?", "%#{word}%")
  end

  scope :purchased, -> { where(is_active: false) }
end
