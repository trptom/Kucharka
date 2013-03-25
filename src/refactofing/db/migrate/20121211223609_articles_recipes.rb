class ArticlesRecipes < ActiveRecord::Migration
  def self.up
    create_table :articles_recipes, :id => false do |t|
        t.references :article
        t.references :recipe
    end
    add_index :articles_recipes, [:article_id, :recipe_id]
    add_index :articles_recipes, [:recipe_id, :article_id]
  end

  def self.down
    drop_table :articles_recipes
  end
end
