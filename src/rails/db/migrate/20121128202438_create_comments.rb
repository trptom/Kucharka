class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :content,            :null => false
      t.references :user,         :null => false
      t.integer :comment_type,    :null => false
      t.references :recipe,       :null => true, :default => nil
      t.references :ingredience,  :null => true, :default => nil
      t.references :article,      :null => true, :default => nil

      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, :recipe_id
    add_index :comments, :ingredience_id
    add_index :comments, :article_id
  end

  def self.down
    drop_table :comments
  end
end
