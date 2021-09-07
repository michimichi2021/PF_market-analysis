class RemoveGenreIdFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :genre_id, :integer
  end
end
