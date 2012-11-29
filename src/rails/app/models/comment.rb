class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe
  belongs_to :ingredience
  belongs_to :article
  
  attr_accessible :content, :comment_type, :created_at, :user_id, :recipe_id, :ingredience_id, :article_id
end
