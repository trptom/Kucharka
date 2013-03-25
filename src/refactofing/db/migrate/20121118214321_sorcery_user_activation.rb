# coding:utf-8

class SorceryUserActivation < ActiveRecord::Migration
  def self.up
    add_column :users, :activation_state, :string, :default => nil
    add_column :users, :activation_token, :string, :default => nil
    add_column :users, :activation_token_expires_at, :datetime, :default => nil
    
    add_index :users, :activation_token

    # pridani admina pri migraci po vytvoreni roli a jeho ulozeni
#    @user = User.new(
#      :username => "admin",
#      :email => "tpraslicak@seznam.cz",
#      :password => "root",
#      :password_confirmation => "root",
#      :note => "Administrátorský účet, automaticky vytvořený při migraci DB.",
#      :active => true,
#      :self_ruleset => -1,
#      :others_ruleset => -1)
#    @user.save
#    @user.activate!
  end

  def self.down
    remove_index :users, :activation_token
    
    remove_column :users, :activation_token_expires_at
    remove_column :users, :activation_token
    remove_column :users, :activation_state
  end
end