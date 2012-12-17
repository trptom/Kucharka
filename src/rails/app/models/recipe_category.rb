class RecipeCategory < ActiveRecord::Base
  has_and_belongs_to_many :recipes

  belongs_to :user

  attr_accessible :descirption, :name, :category_type
end
