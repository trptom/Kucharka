class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.references :recipe, :null => false
      t.references :user,   :null => false
      t.integer :value,     :null => false
      t.text :note,         :null => true,  :default => nil

      t.timestamps
    end
    add_index :marks, :recipe_id
    add_index :marks, :user_id
  end
end
