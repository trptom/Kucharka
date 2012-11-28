class Recipe < ActiveRecord::Base
  belongs_to :user
  attr_accessible :annotation, :content, :name, :level, :estimated_time, :created_at
end
