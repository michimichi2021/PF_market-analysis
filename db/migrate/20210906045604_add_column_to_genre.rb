class AddColumnToGenre < ActiveRecord::Migration[5.2]
  def change
    change_column :genres, :name, :string, null: false
  end
end
