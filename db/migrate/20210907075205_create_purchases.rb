class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.references :user, foreign_key: true, null: false
      t.string :postal_code,null: false
      t.string :address,null: false
      t.string :name,null: false
      t.integer :price,null: false
      t.integer :payment_method,null: false, default:0
      t.timestamps
    end
  end
end
