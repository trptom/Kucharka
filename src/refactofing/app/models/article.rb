# coding:utf-8

class Article < ActiveRecord::Base
  belongs_to :user

  has_many :comments
  has_and_belongs_to_many :recipes

  attr_accessible :title, :annotation, :content, :user_id, :user

  validates :title,
    :length => { :minimum => 3, :maximum => 50, :message => VALIDATION_ERROR_MESSAGE[:article][:title] }

  validates :annotation,
    :length => { :minimum => 50, :maximum => 255, :message => VALIDATION_ERROR_MESSAGE[:article][:annotation] },
    :allow_blank => true,
    :allow_nil => true

  validates :content,
    :length => { :minimum => 100, :message => VALIDATION_ERROR_MESSAGE[:article][:content] }

  validates :user_id,
    :presence => { :message => VALIDATION_ERROR_MESSAGE[:article][:user_id] },
    :numericality => { :only_integer => true, :greater_than => 0, :message => VALIDATION_ERROR_MESSAGE[:article][:user_id] }
  validates :user, :associated => { :message => VALIDATION_ERROR_MESSAGE[:article][:user_id] }
end
