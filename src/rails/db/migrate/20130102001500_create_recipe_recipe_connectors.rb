class CreateRecipeRecipeConnectors < ActiveRecord::Migration
  def self.up
    create_table :recipe_recipe_connectors, :id => false do |t|
      t.column "recipe_id",  :integer, :null => false
      t.column "subrecipe_id", :integer, :null => false
    end
  end

  def self.down
    drop_table :recipe_recipe_connectors
  end
end
