class CreateMarks < ActiveRecord::Migration
  def self.up
    create_table :marks do |t|
      t.references :user
      t.references :recipe
      t.integer :value

      t.timestamps
    end
    add_index :marks, :user_id
    add_index :marks, :recipe_id
  end

  def self.down
    drop_table :marks
  end
end
