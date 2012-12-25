class CreateRecipes < ActiveRecord::Migration
  def up
    create_table :recipes do |t|
      t.string :name,               :null => false
      t.text :annotation,           :null => false
      t.text :content,              :null => false
      t.integer :level,             :null => false, :default => 0
      t.integer :estimated_time,    :null => false, :default => 60
      t.references :user,           :null => false

      t.timestamps
    end
    
    add_index :recipes, :user_id
  end

  def self.down
    drop_table :recipes
  end
end
