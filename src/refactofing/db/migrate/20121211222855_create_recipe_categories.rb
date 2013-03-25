# coding:utf-8

class CreateRecipeCategories < ActiveRecord::Migration
  def self.up
    create_table :recipe_categories do |t|
      t.string :name,           :null => false
      t.text :description,      :null => false
      t.integer :category_type, :null => false, :default => 0
      t.references :user,       :null => false

      t.timestamps
    end

#    @user = User.all.first;
#
#    def create_category(name, description, type, user)
#      @newItem = RecipeCategory.new(
#        :name => name,
#        :description => description,
#        :category_type => type,
#        :user => user
#      );
#      @newItem.save
#    end
#
#    #obdobi (1)
#    create_category("Zimní", "Pokrmy pro zimní období", 1, @user);
#    create_category("Jarní", "Pokrmy pro jarní období", 1, @user);
#    create_category("Letní", "Pokrmy pro letní období", 1, @user);
#    create_category("Podzimní", "Pokrmy pro podzimní období", 1, @user);
#
#    #svatky (2)
#    create_category("Velikonoční", "Pokrmy vhodné na velikonoční svátky", 2, @user);
#    create_category("Vánoční", "Pokrmy vhodné na vánoční svátky", 2, @user);
#
#    #zahranicni (3)
#    create_category("Italská kuchyně", "Pokrmy pocházející z itálie", 3, @user);
  end

  def self.down
    drop_table :recipe_categories
  end
end
