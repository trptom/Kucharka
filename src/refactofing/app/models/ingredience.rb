# coding:utf-8

class Ingredience < ActiveRecord::Base
  belongs_to :user

  has_many :comments
  has_many :ingredienceRecipeConnectors
  has_many :recipes, :through => :ingredienceRecipeConnectors

  has_and_belongs_to_many :ingredienceCategories

  attr_accessible :name, :annotation, :content, :avaliability, :units, :activation_state, :user, :user_id

  validates :name,
    :length => { :minimum => 3, :maximum => 50, :message => "špatná délka názvu (3-50)" },
    :uniqueness => { :case_sensitive => false, :message => "ingredience s daným názvem již existuje" }

  validates :annotation,
    :length => { :minimum => 50, :maximum => 255, :message => "špatná délka stručného popisu (prázdné nebo 50-255 znaků)" },
    :allow_blank => true,
    :allow_nil => true

  validates :content,
    :length => { :minimum => 100, :message => "špatná délka obsahu (alespoň 100 znaků)" },
    :allow_blank => true,
    :allow_nil => true

  validates :avaliability,
    :numericality => { :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 1000, :message => "chybná dostupnost (musí být v rozmezí 1-1000)" }

  validates :activation_state,
    :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 1, :message => "chybný aktivační status (musí být v rozmezí 0-1)" }

  validates :user_id,
    :presence => { :message => "chybný uživatel" },
    :numericality => { :only_integer => true, :greater_than => 0, :message => "chybný uživatel" }
  validates :user, :associated => { :message => "chybný uživatel" }

  validates :units,
    :length => { :minimum => 1, :maximum => 20, :message => "špatná délka názvu jednotek (min. 1 znak)" }
end
