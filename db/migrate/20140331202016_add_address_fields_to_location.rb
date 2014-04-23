class AddAddressFieldsToLocation < ActiveRecord::Migration
  def change
    remove_column :locations, :address
    add_column :locations, :address_one, :string
    add_column :locations, :address_two, :string
    add_column :locations, :city, :string
    add_column :locations, :state, :string
    add_column :locations, :zip, :string
  end
end
