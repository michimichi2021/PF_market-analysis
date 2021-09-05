class ChangeNullToUser < ActiveRecord::Migration[5.2]
  def change
     change_column :users, :nickname, :string
     change_column :users, :profile_image_id, :string
     change_column :users, :introduction, :string
  end
end
