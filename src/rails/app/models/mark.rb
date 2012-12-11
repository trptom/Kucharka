class Mark < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe
  attr_accessible :value
end
