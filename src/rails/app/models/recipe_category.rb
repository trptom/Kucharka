# coding:utf-8

class RecipeCategory < ActiveRecord::Base
  has_and_belongs_to_many :recipes

  belongs_to :user

  attr_accessible :name, :description, :category_type, :user

  validates :name,
    :length => { :minimum => 3, :maximum => 255, :message => "špatná délka názvu (3-255)" },
  :if => :name

  validates :description,
    :length => { :minimum => 20, :message => "špatná délka popisu (>= 20)" },
    :allow_blank => true,
  :if => :description

  validates :category_type,
    :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :message => "chybný věk (musí být v rozmezí 1-100)" },
  :if => :category_type
end
