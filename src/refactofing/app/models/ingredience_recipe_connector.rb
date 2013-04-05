# coding:utf-8

class IngredienceRecipeConnector < ActiveRecord::Base
  belongs_to :ingredience
  belongs_to :recipe
  
  attr_accessible :importance, :quantity

  validates :importance,
    :numericality => { :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 1000, :message => "chybná důležitost (musí být v rozmezí 1-1000)" }

  validates :quantity,
    :numericality => { :greater_than => 0, :message => "chybné množství (musí být > 0)" }
end
