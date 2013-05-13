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

  attr_accessible :name, :annotation, :content, :level, :estimated_time, :created_at, :image, :image_cache, :recipeCategories, :articles, :user, :user_id

  validates :name,
    :length => { :minimum => 3, :maximum => 50, :message => VALIDATION_ERROR_MESSAGE["recipe"]["name"] }

  validates :annotation,
    :length => { :minimum => 50, :maximum => 255, :message => VALIDATION_ERROR_MESSAGE["recipe"]["annotation"] },
    :allow_blank => true,
    :allow_nil => true

  validates :content,
    :length => { :minimum => 100, :message => VALIDATION_ERROR_MESSAGE["recipe"]["content"] }

  validates :level,
    :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than  => LEVEL_TEXT.length, :message => VALIDATION_ERROR_MESSAGE["recipe"]["level"] }

  validates :estimated_time,
    :numericality => { :only_integer => true, :greater_than => 0, :message => VALIDATION_ERROR_MESSAGE["recipe"]["user_id"]}

  validates :user_id,
    :presence => { :message => VALIDATION_ERROR_MESSAGE["recipe"]["user_id"] },
    :numericality => { :only_integer => true, :greater_than => 0, :message => VALIDATION_ERROR_MESSAGE["recipe"]["user_id"] }
  validates :user, :associated => { :message => VALIDATION_ERROR_MESSAGE["recipe"]["user_id"] }

  #validates :image
end
