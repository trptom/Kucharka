class RecipeArticleLink < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :article
  attr_accessible :note
end
