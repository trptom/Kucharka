# coding:utf-8

class IngredienceCategory < ActiveRecord::Base
  has_and_belongs_to_many :ingrediences

  belongs_to :user

  attr_accessible :name, :descirption, :category_type

  validates :name,
    :length => { :minimum => 3, :maximum => 255, :message => "špatná délka názvu (3-50)" },
  :if => :name

  validates :descirption,
    :length => { :minimum => 50, :message => "špatná délka popisu > 50" },
    :allow_blank => true,
  :if => :descirption

  validates :category_type,
    :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :message => "chybný věk (musí být v rozmezí 1-100)" },
  :if => :category_type
end
