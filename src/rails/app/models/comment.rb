class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe
  belongs_to :ingredience
  belongs_to :article
  
  attr_accessible :content, :comment_type, :created_at, :user_id, :recipe_id, :ingredience_id, :article_id

  validates :content,
    :length => { :minimum => 1, :message => "špatná délka obsahu (alespoň 1 znak)" },
  :if => :content

  # nevaliduju, protoze typ se urcuje podle nastavenych asociativnich id, takze
  # tuto promennou zatim nepouzivam
  #validates :comment_type,
  #  :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than  => COMMENT_TYPE_TEXT.length, :message => "typ komentáře není celé číslo 0.."+(COMMENT_TYPE_TEXT.length-1).to_s },
  #:if => :comment_type
end
