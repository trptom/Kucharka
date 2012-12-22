class Recipe < ActiveRecord::Base
  belongs_to :user

  has_many :comments
  has_many :marks
  has_many :ingredienceRecipeConnectors
  has_many :ingrediences, :through => :ingredienceRecipeConnectors

  has_and_belongs_to_many :recipeCategories
  has_and_belongs_to_many :articles

  attr_accessible :id, :annotation, :content, :name, :level, :estimated_time, :created_at
end
