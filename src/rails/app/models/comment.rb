class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe
  belongs_to :ingredience
  
  attr_accessible :content, :title, :comment_type, :created_at
end
