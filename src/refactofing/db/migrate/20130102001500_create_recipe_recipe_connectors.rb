class CreateRecipeRecipeConnectors < ActiveRecord::Migration
  def self.up
    create_table :recipe_recipe_connectors do |t|
      t.column "recipe_id",  :integer, :null => false
      t.column "subrecipe_id", :integer, :null => false

      t.timestamps
    end

    add_index :recipe_recipe_connectors, :recipe_id
    add_index :recipe_recipe_connectors, :subrecipe_id
  end

  def self.down
    drop_table :recipe_recipe_connectors
  end
end
