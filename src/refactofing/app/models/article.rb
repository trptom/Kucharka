# coding:utf-8

class Article < ActiveRecord::Base
  belongs_to :user

  has_many :comments
  has_and_belongs_to_many :recipes

  attr_accessible :title, :annotation, :content, :user_id, :user

  validates :title,
    :length => { :minimum => 3, :maximum => 50, :message => "špatná délka titulku (3-50)" }

  validates :annotation,
    :length => { :minimum => 50, :maximum => 255, :message => "špatná délka anotace (50-255)" }

  validates :content,
    :length => { :minimum => 100, :message => "špatná délka obsahu (alespoň 100 znaků)" }

  validates :user_id,
    :presence => { :message => "chybný uživatel" },
    :numericality => { :only_integer => true, :greater_than => 0, :message => "chybný uživatel" }
  validates :user, :associated => { :message => "chybný uživatel" }
end
