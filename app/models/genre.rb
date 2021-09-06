class Genre < ApplicationRecord
 has_many :tags,dependent: :destroy, foreign_key: 'genre_id'
 has_many :items,through: :tags
 
 validates :name, uniqueness: true, presence: true
end
