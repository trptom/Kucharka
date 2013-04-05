# coding:utf-8

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe
  belongs_to :ingredience
  belongs_to :article
  
  attr_accessible :content, :created_at, :user_id, :recipe_id, :ingredience_id, :article_id

  validates :content,
    :length => { :minimum => 1, :message => "špatná délka obsahu (alespoň 1 znak)" }

  validates :user_id,
    :presence => { :message => "chybný uživatel" },
    :numericality => { :only_integer => true, :greater_than => 0, :message => "chybný uživatel" }
  validates :user, :associated => { :message => "chybný uživatel" }
end
