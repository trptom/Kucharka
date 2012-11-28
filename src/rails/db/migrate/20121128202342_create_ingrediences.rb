class CreateIngrediences < ActiveRecord::Migration
  def self.up
    create_table :ingrediences do |t|
      t.string :name,           :null => false
      t.text :annotation,       :null => false
      t.text :content,          :null => false
      t.integer :avaliability,  :null => false, :default => 1
      t.references :user,       :null => false

      t.timestamps
    end
    add_index :ingrediences, :user_id
  end

  def self.down
    drop_table :ingrediences
  end
end
