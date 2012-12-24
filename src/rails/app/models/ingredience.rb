class Ingredience < ActiveRecord::Base
  belongs_to :user

  has_many :comments
  has_many :ingredienceRecipeConnectors
  has_many :recipes, :through => :ingredienceRecipeConnectors

  has_and_belongs_to_many :ingredienceCategories

  attr_accessible :name, :annotation, :content, :avaliability, :units

  validates :name,
    :length => { :minimum => 3, :maximum => 50, :message => "špatná délka názvu (3-50)" },
  :if => :name

  validates :annotation,
    :length => { :minimum => 50, :maximum => 255, :message => "špatná délka anotace (50-255)" },
  :if => :annotation

  validates :content,
    :length => { :minimum => 100, :message => "špatná délka obsahu (alespoň 100 znaků)" },
  :if => :content

  validates :avaliability,
    :numericality => { :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 1000, :message => "chybná dostupnost (musí být v rozmezí 1-1000)" },
  :if => :avaliability

  #validates :units,
  #:if => :units
end
