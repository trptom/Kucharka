class Recipe < ActiveRecord::Base
  belongs_to :user
  attr_accessible :annotation, :content, :name, :created_at
end
