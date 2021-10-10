class Item < ApplicationRecord
  belongs_to :user

  has_many :tags, dependent: :destroy
  has_many :genres, through: :tags
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one :purchase, dependent: :destroy

  has_many :notifications, dependent: :destroy

  validates :name, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 1_000_000 }
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

  # 通知機能のメソッド
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      item_id: id,
      visited_id: user_id,
      action: "like"
    )
    notification.save if notification.valid?
  end

  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(item_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, comment_id, user_id)
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.where.not(user_id: current_user.id).new(
      item_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  def create_notification_purchase_by(current_user)
    notification = current_user.active_notifications.new(
      item_id: id,
      visited_id: user_id,
      action: "purchase"
    )
    notification.save if notification.valid?
  end

  scope :purchased, -> { where(is_active: false) }

  scope :days_ago, -> { where(updated_at: Time.zone.today.beginning_of_day.ago(6.days)..Time.zone.today.end_of_day) }
  scope :weeks_ago, -> { where(updated_at: Time.zone.today.beginning_of_day.ago(4.week)..Time.zone.today.end_of_day) }
  scope :months_ago, -> { where(updated_at: Time.zone.today.beginning_of_day.ago(6.month)..Time.zone.today.end_of_day) }
end
