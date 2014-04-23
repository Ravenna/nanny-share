class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.integer :age
      t.string :gender
      t.references :user, index: true

      t.timestamps
    end
  end
end
