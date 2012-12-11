class Mark < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :user
  attr_accessible :note, :value
end
