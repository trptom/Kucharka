class IngredienceCategoryLink < ActiveRecord::Base
  belongs_to :ingredience
  belongs_to :ingredienceCategory

  attr_accessible :note
end
