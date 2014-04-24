class AddDefaultToChildCounter < ActiveRecord::Migration
  def up
      change_column :users, :counter, :integer, :default => 0
  end

  def down
      change_column :users, :counter, :integer, :default => nil
  end
end
