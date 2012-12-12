class RecipeCategoriesRecipes < ActiveRecord::Migration
  def self.up
    create_table :recipe_categories_recipes, :id => false do |t|
        t.references :recipe_category
        t.references :recipe
    end
#    add_index :recipe_categories_recipes, [:recipe_category_id, :recipe_id]
#    add_index :recipe_categories_recipes, [:recipe_id, :recipe_category_id]
  end

  def self.down
    drop_table :recipe_categories_recipes
  end
end
