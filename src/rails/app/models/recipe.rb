# coding:utf-8

class Recipe < ActiveRecord::Base
  belongs_to :user

  has_many :comments
  has_many :marks
  has_many :ingredienceRecipeConnectors
  has_many :ingrediences, :through => :ingredienceRecipeConnectors
  
  has_many :subrecipes,
    :foreign_key => 'recipe_id', :class_name => 'RecipeRecipeConnector'

  has_and_belongs_to_many :recipeCategories
  has_and_belongs_to_many :articles

  mount_uploader :image, RecipeImageUploader

  attr_accessible :id, :name, :annotation, :content, :level, :estimated_time, :activation_state, :created_at, :image

  validates :name,
    :length => { :minimum => 3, :maximum => 50, :message => "špatná délka názvu (3-50)" },
  :if => :name

  validates :annotation,
    :length => { :minimum => 50, :maximum => 255, :message => "špatná délka anotace (50-255)" },
  :if => :annotation

  validates :content,
    :length => { :minimum => 100, :message => "špatná délka obsahu (alespoň 100 znaků)" },
  :if => :content

  validates :level,
    :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than  => LEVEL_TEXT.length, :message => "level není celé číslo 0.."+(LEVEL_TEXT.length-1).to_s },
  :if => :level

  validates :estimated_time,
    :numericality => { :only_integer => true, :greater_than => 0, :message => "level není celé číslo > 0" },
  :if => :estimated_time

  #validates :image
end
