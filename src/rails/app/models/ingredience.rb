class Ingredience < ActiveRecord::Base
  belongs_to :user

  has_many :comments
  has_and_belongs_to_many :ingredienceCategories

  attr_accessible :annotation, :avaliability, :content, :name
end
