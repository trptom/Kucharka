# coding:utf-8

class UpdateToAcceptNil < ActiveRecord::Migration
  def self.up
    change_column :recipes, :annotation, :text, :null => true
    change_column :ingrediences, :annotation, :text, :null => true
    change_column :ingrediences, :content, :text, :null => true
    change_column :articles, :annotation, :text, :null => true
    change_column :recipe_categories, :description, :text, :null => true
    change_column :ingredience_categories, :description, :text, :null => true
  end

  def self.down
    change_column :recipes, :annotation, :text, :null => false
    change_column :ingrediences, :annotation, :text, :null => false
    change_column :ingrediences, :content, :text, :null => false
    change_column :articles, :annotation, :text, :null => false
    change_column :recipe_categories, :description, :text, :null => false
    change_column :ingredience_categories, :description, :text, :null => false
  end
end
