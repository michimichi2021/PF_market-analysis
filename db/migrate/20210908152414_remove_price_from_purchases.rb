class RemovePriceFromPurchases < ActiveRecord::Migration[5.2]
  def change
    remove_column :purchases, :price, :integer
  end
end
