# coding:utf-8

class Mark < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe

  attr_accessible :value, :recipe_id, :recipe, :user_id, :user

  validates :value,
    :numericality => { :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5, :message => VALIDATION_ERROR_MESSAGE[:mark][:value] },
  :if => :value
end
