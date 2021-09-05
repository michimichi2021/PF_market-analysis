class AddTelephoneNumberToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :telephone_number, :string
  end
end
