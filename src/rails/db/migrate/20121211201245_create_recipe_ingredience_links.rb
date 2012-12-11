class CreateRecipeIngredienceLinks < ActiveRecord::Migration
  def change
    create_table :recipe_ingredience_links do |t|
      t.references :recipe,       :null => false
      t.references :ingredience,  :null => false
      t.integer :importance,      :null => false, :default => 1
      t.integer :quantity,        :null => false, :default => 1
      t.text :note,               :null => true,  :default => nil

      t.timestamps
    end
    add_index :recipe_ingredience_links, :recipe_id
    add_index :recipe_ingredience_links, :ingredience_id
  end
end
