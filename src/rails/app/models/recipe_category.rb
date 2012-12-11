class RecipeCategory < ActiveRecord::Base
  has_many :recipeCategoryLinks

  attr_accessible :name, :type
end
