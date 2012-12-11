class Recipe < ActiveRecord::Base
  belongs_to :user

  has_many :comments
  has_many :recipeCategoryLinks

  attr_accessible :annotation, :content, :name, :level, :estimated_time, :created_at
end
