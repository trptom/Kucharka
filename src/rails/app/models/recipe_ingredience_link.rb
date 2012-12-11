class RecipeIngredienceLink < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredience
  attr_accessible :importance, :note, :quantity
end
