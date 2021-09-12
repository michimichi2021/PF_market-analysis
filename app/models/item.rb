class Item < ApplicationRecord

  belongs_to :user

  has_many :tags,dependent: :destroy
  has_many :genres,through: :tags
  has_many :comments, dependent: :destroy
  has_one :purchase,dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end


  def save_genre(save_genres)
    current_genres = self.genres.pluck(:name) unless self.genres.nil?
    old_genres = current_genres - save_genres
    new_genres = save_genres - current_genres

    old_genres.each do |old_name|
      self.genres.delete Genre.find_by(name: old_name)
    end

    new_genres.each do |new_name|
      new_item_genre = Genre.find_or_create_by(name: new_name)
      self.genres << new_item_genre
    end
  end

  def self.search(word)
   where("name LIKE?","%#{word}%")
  end
  
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } 
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } 
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } 
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) } 
  
  scope :purchased,-> { where(is_active: false) } 

  has_one_attached :image

  validate :image_type

  private

  def image_type
    if !image.blob.content_type.in?(%('image/jpeg image/png'))
      image.purge # Rails6では、この1行は必要ない
      errors.add(:image, 'はJPEGまたはPNG形式を選択してアップロードしてください')
    end
  end


end
