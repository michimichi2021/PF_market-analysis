class AddNotnullToPurchase < ActiveRecord::Migration[5.2]
  def change
     change_column :purchases, :item_id, :integer, null: false
  end
end
