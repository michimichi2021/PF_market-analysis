class Tag < ApplicationRecord
  belongs_to :item
  belongs_to :genre

  validates :item_id, presence: true
  validates :genre_id, presence: true
end
