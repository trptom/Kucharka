class User < ActiveRecord::Base
  attr_accessible :description, :email, :id, :login, :password, :userName
end
