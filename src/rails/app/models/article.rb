class Article < ActiveRecord::Base
  belongs_to :user

  has_many :comments
  has_and_belongs_to_many :recipes

  attr_accessible :annotation, :content, :title
end
