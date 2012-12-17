class IngredienceCategory < ActiveRecord::Base
  has_and_belongs_to_many :ingrediences

  belongs_to :user

  attr_accessible :descirption, :name, :category_type
end
