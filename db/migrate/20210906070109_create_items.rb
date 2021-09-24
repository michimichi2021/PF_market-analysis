class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :user, foreign_key: true, null: false
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.boolean :is_active, default: true, null: false
      t.string :shipping_fee, null: false
      t.string :shipping_method, null: false
      t.string :shipping_area, null: false
      t.integer :preparation_day, null: false
      t.timestamps
    end
  end
end
