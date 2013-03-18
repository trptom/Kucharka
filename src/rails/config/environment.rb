# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
PokusSorcery::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :address  => "smtp.seznam.cz",
  :port  => 25,
  :user_name  => "tpraslicak@seznam.cz",
  :password  => "",
  :authentication  => :login
}