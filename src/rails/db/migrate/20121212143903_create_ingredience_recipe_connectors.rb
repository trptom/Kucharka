class CreateIngredienceRecipeConnectors < ActiveRecord::Migration
  def self.up
    create_table :ingredience_recipe_connectors do |t|
      t.references :ingredience
      t.references :recipe
      t.integer :quantity,        :null => false, :default => 1
      t.integer :importance,      :null => false, :default => 1

      t.timestamps
    end
#    add_index :ingredience_recipe_connectors, [:ingredience_id, :recipe_id]
#    add_index :ingredience_recipe_connectors, [:recipe_id, :ingredience_id]
  end

  def self.down
    drop_table :ingredience_recipe_connectors
  end
end
