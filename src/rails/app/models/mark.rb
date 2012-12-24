class Mark < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe

  attr_accessible :value

  validates :value,
    :numericality => { :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5, :message => "chybná hodnota (musí být v rozmezí 1-5)" },
  :if => :value
end
