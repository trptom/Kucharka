# coding:utf-8

class SorceryUserActivation < ActiveRecord::Migration
  def self.up
    add_column :users, :activation_state, :string, :default => nil
    add_column :users, :activation_token, :string, :default => nil
    add_column :users, :activation_token_expires_at, :datetime, :default => nil
    
    add_index :users, :activation_token

    def create_role(name, title, description, role)
      r = Role.new(
        :name => name,
        :title => title,
        :description => description,
        :the_role => role)
      r.save
      return r
    end

    # vytvoreni zakladnich roli
    @admin = create_role("admin", "Administrator", "Administrátor celého systému", "{\"system\":{\"administrator\":true}}")
    create_role("banned_user", "Banned user", "Uživatel s banem", "{}")

    # pridani admina pri migraci po vytvoreni roli a jeho ulozeni
    @user = User.new(
      :username => "admin",
      :email => "root@kucharka.cz",
      :password => "root",
      :password_confirmation => "root",
      :note => "Administrátorský účet, automaticky vytvořený při migraci DB.",
      :role_id => @admin)
    @user.save
    @user.activate!
  end

  def self.down
    remove_index :users, :activation_token
    
    remove_column :users, :activation_token_expires_at
    remove_column :users, :activation_token
    remove_column :users, :activation_state
  end
end