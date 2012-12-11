class Ingredience < ActiveRecord::Base
  belongs_to :user

  has_many :comments

  attr_accessible :annotation, :avaliability, :content, :name
end
