class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :annotation
      t.text :content
      t.references :user

      t.timestamps
    end
    add_index :recipes, :user_id
  end
end
