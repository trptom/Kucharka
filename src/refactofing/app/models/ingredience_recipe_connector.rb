# coding:utf-8

class IngredienceRecipeConnector < ActiveRecord::Base
  belongs_to :ingredience
  belongs_to :recipe
  
  attr_accessible :importance, :quantity

  validates :importance,
    :numericality => { :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 1000, :message => VALIDATION_ERROR_MESSAGE[:ingredience_recipe_connector][:importance] }

  validates :quantity,
    :numericality => { :greater_than => 0, :message => VALIDATION_ERROR_MESSAGE[:ingredience_recipe_connector][:quantity] }
end
