# coding:utf-8

class IngredienceCategory < ActiveRecord::Base
  has_and_belongs_to_many :ingrediences

  belongs_to :user

  attr_accessible :name, :description, :category_type, :user, :user_id

  validates :name,
    :length => { :minimum => 3, :maximum => 255, :message => "špatná délka názvu (3-255)" },
  :if => :name

  validates :description,
    :length => { :minimum => 20, :message => "špatná délka popisu (>= 20)" },
    :allow_blank => true,
  :if => :description

  validates :category_type,
    :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :message => "chybná kategorie (musí být > 0)" },
  :if => :category_type

  validates :user_id,
    :presence => { :message => "chybný uživatel" },
    :numericality => { :only_integer => true, :greater_than => 0, :message => "chybný uživatel" }
  validates :user, :associated => { :message => "chybný uživatel" }
end
