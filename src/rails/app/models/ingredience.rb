class Ingredience < ActiveRecord::Base
  belongs_to :user

  has_many :comments
  has_many :ingredienceRecipeConnectors
  has_many :recipes, :through => :ingredienceRecipeConnectors

  has_and_belongs_to_many :ingredienceCategories

  attr_accessible :annotation, :avaliability, :content, :name, :units
end
