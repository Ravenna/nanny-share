class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :start_date, :datetime
    add_column :users, :number_of_children, :integer
    add_column :users, :age_of_children, :string
  end
end
