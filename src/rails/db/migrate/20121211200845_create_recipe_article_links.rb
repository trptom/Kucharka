class CreateRecipeArticleLinks < ActiveRecord::Migration
  def change
    create_table :recipe_article_links do |t|
      t.references :recipe,   :null => false
      t.references :article,  :null => false
      t.text :note,           :null => true,  :default => nil

      t.timestamps
    end
    add_index :recipe_article_links, :recipe_id
    add_index :recipe_article_links, :article_id
  end
end
