class RecipeCategory < ActiveRecord::Base
  has_and_belongs_to_many :recipes

  attr_accessible :descirption, :name, :type
end
