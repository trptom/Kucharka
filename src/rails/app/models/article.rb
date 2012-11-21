class Article < ActiveRecord::Base
  belongs_to :user
  attr_accessible :annotation, :content, :title
end
