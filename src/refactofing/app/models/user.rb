# coding:utf-8

class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :recipes
  has_many :articles
  has_many :ingrediences
  has_many :comments
  has_many :marks
  has_many :ingredienceCategories
  has_many :recipeCategories

  attr_accessible :username, :email, :password, :password_confirmation, :first_name, :second_name, :age, :note, :active, :self_ruleset, :others_ruleset, :activation_state, :activation_token, :activation_token_expires_at

  validates :username,
    :format => { :with => /^[a-zA-Z0-9\-\.\_]{3,30}$/, :message => "chybný formát uživatelského jména (může obsahovat znaky A-Z (bez diakritiky), čísla a znaky ._-, délka 3-30)" },
    :uniqueness => { :case_sensitive => false, :message => "uživatel s daným uživatelským jménem již existuje" }

  validates :email,
    :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "chybný formát emailu" },
    :uniqueness => { :case_sensitive => false, :message => "uživatel s daným emailem již existuje" }

  validates :password,
    :length => { :minimum => 3, :maximum => 255, :message => "špatná délka hesla (3-255)" },
    :confirmation => { :message => "heslo a kontrola hesla jsou různé"},
    :allow_blank => false,
    :allow_nil => false,
  :if => :password

  validates :first_name,
    :format => { :with => /^(|.{2,})$/, :message => "chybný formát jména (alespoň 2 znaky)" },
    :allow_nil => true,
    :allow_blank => true

  validates :second_name,
    :format => { :with => /^(|.{2,})$/, :message => "chybný formát příjmení (alespoň 2 znaky)" },
    :allow_nil => true,
    :allow_blank => true

  validates :age, 
    :numericality => { :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 100, :message => "chybný věk (musí být v rozmezí 1-100)" },
    :allow_nil => true,
    :allow_blank => true

  #validates :note

  #validates :active

  validates :self_ruleset,
    :numericality => { :only_integer => true, :message => "ruleset (self) není celé číslo" }

  validates :others_ruleset,
    :numericality => { :only_integer => true, :message => "ruleset (others) není celé číslo" }

#  validates :crypted_password,
#    :length => { :minimum => 1, :message => "špatné heslo" },
#    :allow_nil => false,
#    :allow_blank => false

  #validates :activation_state

  #validates :activation_token

  #validates :activation_token_expires_at
end
