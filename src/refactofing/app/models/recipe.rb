# coding:utf-8

class Recipe < ActiveRecord::Base
  belongs_to :user

  has_many :comments
  has_many :marks
  has_many :ingredienceRecipeConnectors
  has_many :ingrediences, :through => :ingredienceRecipeConnectors

  has_and_belongs_to_many :recipeCategories
  has_and_belongs_to_many :articles

  has_many :subrecipes,
    :foreign_key => 'recipe_id', :class_name => 'RecipeRecipeConnector'

  mount_uploader :image, RecipeImageUploader

  attr_accessible :name, :annotation, :content, :level, :estimated_time, :created_at, :image, :recipeCategories, :articles, :user, :user_id

  validates :name,
    :length => { :minimum => 3, :maximum => 50, :message => "špatná délka názvu (3-50)" }

  validates :annotation,
    :length => { :minimum => 50, :maximum => 255, :message => "špatná délka anotace (50-255)" }

  validates :content,
    :length => { :minimum => 100, :message => "špatná délka obsahu (alespoň 100 znaků)" }

  validates :level,
    :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than  => LEVEL_TEXT.length, :message => "level není celé číslo 0.."+(LEVEL_TEXT.length-1).to_s }

  validates :estimated_time,
    :numericality => { :only_integer => true, :greater_than => 0, :message => "level není celé číslo > 0" }

  validates :user_id,
    :presence => { :message => "chybný uživatel" },
    :numericality => { :only_integer => true, :greater_than => 0, :message => "chybný uživatel" }
  validates :user, :associated => { :message => "chybný uživatel" }

  #validates :image
end
