class Ingredience < ActiveRecord::Base
  belongs_to :user

  has_many :comments
  has_many :ingredienceCategoryLinks

  attr_accessible :annotation, :avaliability, :content, :name
end
