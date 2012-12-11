class IngredienceCategory < ActiveRecord::Base
  has_and_belongs_to_many :ingrediences

  attr_accessible :descirption, :name, :type
end
