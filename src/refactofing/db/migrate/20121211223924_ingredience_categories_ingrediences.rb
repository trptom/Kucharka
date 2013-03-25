class IngredienceCategoriesIngrediences < ActiveRecord::Migration
  def self.up
    create_table :ingredience_categories_ingrediences, :id => false do |t|
        t.references :ingredience_category
        t.references :ingredience
    end
#    add_index :ingredience_categories_ingrediences, [:ingredience_category_id, :ingredience_id]
#    add_index :ingredience_categories_ingrediences, [:ingredience_id, :ingredience_category_id]
  end

  def self.down
    drop_table :ingredience_categories_ingrediences
  end
end
