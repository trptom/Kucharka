# coding:utf-8

class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :username, :email, :password, :password_confirmation, :first_name, :second_name, :age, :note, :active, :role_id, :activation_state, :activation_token, :activation_token_expires_at

  validates_length_of :username, :minimum => 3, :message => "minimální delka uživatelského jména: 3 znaky", :if => :username
  validates_length_of :password, :minimum => 3, :message => "minimální délka hesla: 3 znaky", :if => :password
  validates_confirmation_of :password, :message => "heslo a kontrola hesla jsou různé", :if => :password

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "chybný formát emailu", :if => :email
end
