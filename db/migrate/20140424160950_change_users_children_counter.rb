class ChangeUsersChildrenCounter < ActiveRecord::Migration
  def change
    remove_column :users, :counter
    add_column :users, :children_count, :integer, :default => 0
      
    User.reset_column_information
      
    User.all.each do |u|
      u.update_attribute(:children_count, u.children.length)
    end 
  end
  
  
end
