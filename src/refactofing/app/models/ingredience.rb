# coding:utf-8

class Ingredience < ActiveRecord::Base
  belongs_to :user

  has_many :comments
  has_many :ingredienceRecipeConnectors
  has_many :recipes, :through => :ingredienceRecipeConnectors

  has_and_belongs_to_many :ingredienceCategories

  attr_accessible :name, :annotation, :content, :avaliability, :units, :activation_state, :user, :user_id

  validates :name,
    :length => { :minimum => 3, :maximum => 50, :message => VALIDATION_ERROR_MESSAGE[:ingredience][:name][:length] },
    :uniqueness => { :case_sensitive => false, :message => VALIDATION_ERROR_MESSAGE[:ingredience][:name][:uniqueness] }

  validates :annotation,
    :length => { :minimum => 50, :maximum => 255, :message => VALIDATION_ERROR_MESSAGE[:ingredience][:annotation] },
    :allow_blank => true,
    :allow_nil => true

  validates :content,
    :length => { :minimum => 100, :message => VALIDATION_ERROR_MESSAGE[:ingredience][:content] },
    :allow_blank => true,
    :allow_nil => true

  validates :avaliability,
    :numericality => { :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 1000, :message => VALIDATION_ERROR_MESSAGE[:ingredience][:avaliability] }

  validates :activation_state,
    :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 1, :message => VALIDATION_ERROR_MESSAGE[:ingredience][:activation_state] }

  validates :user_id,
    :presence => { :message => VALIDATION_ERROR_MESSAGE[:ingredience][:user_id] },
    :numericality => { :only_integer => true, :greater_than => 0, :message => VALIDATION_ERROR_MESSAGE[:ingredience][:user_id] }
  validates :user, :associated => { :message => VALIDATION_ERROR_MESSAGE[:ingredience][:user_id] }

  validates :units,
    :length => { :minimum => 1, :maximum => 20, :message => VALIDATION_ERROR_MESSAGE[:ingredience][:units] }
end
