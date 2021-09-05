class ChangeColumnToUser < ActiveRecord::Migration[5.2]
  def change
     change_column :users, :nickname, :string, null: false
     change_column :users, :introduction, :string, null: false
     change_column :users, :last_name, :string, null: false
     change_column :users, :first_name, :string, null: false
     change_column :users, :last_name_kana, :string, null: false
     change_column :users, :first_name_kana, :string, null: false
     change_column :users, :postal_code, :string, null: false
     change_column :users, :address, :string, null: false
     change_column :users, :telephone_number, :string, null: false
     change_column :users, :profile_image_id, :string, null: false
     change_column :users, :is_deleted, :boolean, null: false, default: false
  end
end
