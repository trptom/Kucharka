class Recipe < ActiveRecord::Base
  belongs_to :user

  has_many :comments

  attr_accessible :annotation, :content, :name, :level, :estimated_time, :created_at
end
