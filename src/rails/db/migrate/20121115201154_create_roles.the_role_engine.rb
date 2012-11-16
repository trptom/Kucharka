# This migration comes from the_role_engine (originally 20111025025129)
class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|

      t.string :name,        :null => false
      t.string :title,       :null => false
      t.text   :description, :null => false
      t.text   :the_role,    :null => false

      t.timestamps
    end
    
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
    @admin = create_role("admin", "Administrator", "Administrator celeho systemu", "{\"system\":{\"administrator\":true}}")
    create_role("banned_user", "Banned user", "Uzivatel s banem", "{}")

    # pridani admina pri migraci po vytvoreni roli a jeho ulozeni
    @user = User.new(
      :username => "Admin",
      :password => "root",
      :password_confirmation => "root",
      :note => "Administratorsky ucet, automaticky vytvoreny pri migraci DB.",
      :role_id => @admin)
    @user.save
  end

  def self.down
    drop_table :roles
  end
end