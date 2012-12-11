class CreateRecipeCategories < ActiveRecord::Migration
  def change
    create_table :recipe_categories do |t|
      t.string :name,   :null => false
      t.integer :type,  :null => false, :default => 0

      t.timestamps
    end
  end
end
