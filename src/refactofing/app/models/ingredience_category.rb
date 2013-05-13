# coding:utf-8

class IngredienceCategory < ActiveRecord::Base
  has_and_belongs_to_many :ingrediences

  belongs_to :user

  attr_accessible :name, :description, :category_type, :user, :user_id

  validates :name,
    :length => { :minimum => 3, :maximum => 255, :message => VALIDATION_ERROR_MESSAGE["ingredience_category"]["name"] }

  validates :description,
    :length => { :minimum => 20, :message => VALIDATION_ERROR_MESSAGE["ingredience_category"]["description"] },
    :allow_blank => true

  validates :category_type,
    :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :message => VALIDATION_ERROR_MESSAGE["ingredience_category"]["category_type"] }

  validates :user_id,
    :presence => { :message => VALIDATION_ERROR_MESSAGE["ingredience_category"]["user_id"] },
    :numericality => { :only_integer => true, :greater_than => 0, :message => VALIDATION_ERROR_MESSAGE["ingredience_category"]["user_id"] }
  validates :user, :associated => { :message => VALIDATION_ERROR_MESSAGE["ingredience_category"]["user_id"] }
end
