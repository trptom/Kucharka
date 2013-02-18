class CreateIngredienceCategories < ActiveRecord::Migration
  def self.up
    create_table :ingredience_categories do |t|
      t.string :name,           :null => false
      t.text :description,      :null => false
      t.integer :category_type, :null => false, :default => 0
      t.references :user,       :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :ingredience_categories
  end
end
