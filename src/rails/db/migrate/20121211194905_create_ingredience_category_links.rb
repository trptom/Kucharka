class CreateIngredienceCategoryLinks < ActiveRecord::Migration
  def change
    create_table :ingredience_category_links do |t|
      t.references :ingredience
      t.references :ingredienceCategory
      t.text; :note

      t.timestamps
    end
    add_index :ingredience_category_links, :ingredience_id
    add_index :ingredience_category_links, :ingredienceCategory_id
  end
end
