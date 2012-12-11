class CreateRecipeCategories < ActiveRecord::Migration
  def change
    create_table :recipe_categories do |t|
      t.string :name
      t.integer; :type

      t.timestamps
    end
  end
end
