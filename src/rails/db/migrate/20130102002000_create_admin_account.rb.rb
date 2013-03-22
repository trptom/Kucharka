# coding:utf-8

class CreateAdminAccount < ActiveRecord::Migration
  def self.up
    # pridani admina pri migraci po vytvoreni roli a jeho ulozeni
    @user = User.new(
      :username => "admin",
      :email => "tpraslicak@seznam.cz",
      :password => "root",
      :password_confirmation => "root",
      :note => "Administrátorský účet, automaticky vytvořený při migraci DB.",
      :active => true,
      :self_ruleset => -1,
      :others_ruleset => -1)
    @user.save
    @user.activate!
  end

  def self.down
    User.delete_all
  end
end
