# coding:utf-8

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe
  belongs_to :ingredience
  belongs_to :article
  
  attr_accessible :content, :created_at, :user_id, :recipe_id, :ingredience_id, :article_id

  validates :content,
    :length => { :minimum => 1, :message => VALIDATION_ERROR_MESSAGE[:comment][:content] }

  validates :user_id,
    :presence => { :message => VALIDATION_ERROR_MESSAGE[:comment][:user_id] },
    :numericality => { :only_integer => true, :greater_than => 0, :message => VALIDATION_ERROR_MESSAGE[:comment][:user_id] }
  validates :user, :associated => { :message => VALIDATION_ERROR_MESSAGE[:comment][:user_id] }
end
