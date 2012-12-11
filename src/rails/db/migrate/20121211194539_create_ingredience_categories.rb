class CreateIngredienceCategories < ActiveRecord::Migration
  def change
    create_table :ingredience_categories do |t|
      t.string :name
      t.integer; :type

      t.timestamps
    end
  end
end
