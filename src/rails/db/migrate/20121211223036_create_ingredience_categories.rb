class CreateIngredienceCategories < ActiveRecord::Migration
  def change
    create_table :ingredience_categories do |t|
      t.string :name,           :null => false
      t.text :descirption,      :null => false
      t.integer :category_type, :null => false, :default => 0
      t.references :user,       :null => false

      t.timestamps
    end
  end
end
