class DropAgeOfChildrenFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :number_of_children, :integer
    remove_column :users, :age_of_children, :string
  end
end
