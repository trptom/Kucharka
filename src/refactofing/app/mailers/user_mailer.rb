# coding:utf-8

class UserMailer < ActionMailer::Base
  default from: "info@kucharka.com"

  def activation_needed_email(user)
    @user = user
    @url = "http://kucharka-pilot.herokuapp.com"
    @url_activation  = "http://kucharka-pilot.herokuapp.com/users/#{user.activation_token}/activate?src=email"
    mail(:to => user.email,
         :subject => "Vítejte v aplikaci Kuchařka")
  end

  def activation_success_email(user)
    @user = user
    @url = "http://kucharka-pilot.herokuapp.com"
    mail(:to => user.email,
         :subject => "Účet aktivován")
  end
end
