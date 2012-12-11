class IngredienceCategory < ActiveRecord::Base
  has_many :ingredienceCategoryLinks

  attr_accessible :name, :type
end
