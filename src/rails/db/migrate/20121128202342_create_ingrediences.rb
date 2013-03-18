# coding:utf-8

class CreateIngrediences < ActiveRecord::Migration
  def self.up
    create_table :ingrediences do |t|
      t.string :name,           :null => false
      t.text :annotation,       :null => false
      t.text :content,          :null => false
      t.integer :avaliability,  :null => false, :default => 1
      t.string :units,          :null => false
      t.references :user,       :null => false
      t.integer :activation_state,  :null => false, :default => 0

      t.timestamps
    end
    add_index :ingrediences, :user_id
#    execute "ALTER TABLE ingrediences ADD UNIQUE KEY (name);"

    def add_item(name, annotation, content, avaliability, units, userId)
      @newInstance = Ingredience.new
      @newInstance.name = name;
      @newInstance.annotation = annotation
      @newInstance.content = content
      @newInstance.avaliability = avaliability
      @newInstance.units = units;
      @newInstance.user_id = userId;
      @newInstance.activation_state = 1;

      @newInstance.save
    end

    add_item("cukr", "", "", 1000, "kg", 1)
    add_item("sůl", "", "", 1000, "kg", 1)
    add_item("pepř", "", "", 1000, "kg", 1)
    add_item("mléko", "", "", 1000, "l", 1)
  end

  def self.down
    drop_table :ingrediences
  end
end
