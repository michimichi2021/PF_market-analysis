class Genre < ApplicationRecord
  has_many :tags, dependent: :destroy
  has_many :items, through: :tags

  validates :name, uniqueness: true, presence: true
end
