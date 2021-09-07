class AddNotnullToItem < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :user_id, :integer, null: false
    change_column :items, :genre_id, :integer, null: false
  end
end
