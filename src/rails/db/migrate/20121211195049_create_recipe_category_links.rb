class CreateRecipeCategoryLinks < ActiveRecord::Migration
  def change
    create_table :recipe_category_links do |t|
      t.references :recipe,         :null => false
      t.references :recipeCategory, :null => false
      t.text :note,                 :null => true,  :default => nil

      t.timestamps
    end
    add_index :recipe_category_links, :recipe_id
    add_index :recipe_category_links, :recipeCategory_id
  end
end
