class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username,         :null => false
      t.string :email,            :null => false
      t.string :crypted_password, :null => false
      t.string :salt,             :default => nil
      t.integer :role_id,         :default => nil
      t.string :first_name,       :default => nil
      t.string :second_name,      :default => nil
      t.string :age,              :default => nil
      t.text :note,               :default => nil
      t.boolean :active,          :default => true, :null => false

      t.timestamps
    end

    # primary keys
    execute "ALTER TABLE users ADD UNIQUE KEY (username);"
    execute "ALTER TABLE users ADD UNIQUE KEY (email);"
  end

  def self.down
    drop_table :users
  end
end