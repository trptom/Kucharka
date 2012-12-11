class CreateRecipeCategoryLinks < ActiveRecord::Migration
  def change
    create_table :recipe_category_links do |t|
      t.references :recipe
      t.references :recipeCategory
      t.text; :note

      t.timestamps
    end
    add_index :recipe_category_links, :recipe_id
    add_index :recipe_category_links, :recipeCategory_id
  end
end
