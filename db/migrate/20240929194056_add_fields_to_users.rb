class AddFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :phone_number, :string
    add_column :users, :status, :boolean
    
  end
end
