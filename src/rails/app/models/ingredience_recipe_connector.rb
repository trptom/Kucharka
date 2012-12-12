class IngredienceRecipeConnector < ActiveRecord::Base
  belongs_to :ingredience
  belongs_to :recipe
  
  attr_accessible :importance, :quantity
end
