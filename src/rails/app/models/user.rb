class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :username, :email, :password, :password_confirmation, :name, :note, :active, :role_id

  validates_length_of :password, :minimum => 3, :message => "minimalni delka hesla: 3 znaky", :if => :password
  validates_confirmation_of :password, :message => "heslo a kontrola hesla jsou ruzne", :if => :password
end
