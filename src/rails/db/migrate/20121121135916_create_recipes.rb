class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name,     :null => false
      t.text :annotation, :null => false
      t.text :content,    :null => false
      t.references :user, :null => false

      t.timestamps
    end
    add_index :recipes, :user_id
  end
end
