class RecipeCategoryLink < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :recipeCategory

  attr_accessible :note
end
