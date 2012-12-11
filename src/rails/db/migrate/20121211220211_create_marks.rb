class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.references :user
      t.references :recipe
      t.integer :value

      t.timestamps
    end
    add_index :marks, :user_id
    add_index :marks, :recipe_id
  end
end
