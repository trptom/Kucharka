class Article < ActiveRecord::Base
  belongs_to :user

  has_many :comments
  has_and_belongs_to_many :recipes

  attr_accessible :title, :annotation, :content

  validates :title,
    :length => { :minimum => 3, :maximum => 50, :message => "špatná délka titulku (3-50)" },
  :if => :title

  validates :annotation,
    :length => { :minimum => 50, :maximum => 255, :message => "špatná délka anotace (50-255)" },
  :if => :annotation

  validates :content,
    :length => { :minimum => 100, :message => "špatná délka obsahu (alespoň 100 znaků)" },
  :if => :content
end
