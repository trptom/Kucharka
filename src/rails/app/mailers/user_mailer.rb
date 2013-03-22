# coding:utf-8

class UserMailer < ActionMailer::Base
  default from: "info@kucharka.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.activation_needed_email.subject
  #
  def activation_needed_email(user)
    @user = user
    @url  = "http://kucharka-pilot.herokuapp.com/users/#{user.activation_token}/activate?src=email"
    mail(:to => user.email,
         :subject => "Vítejte v aplikaci Kuchařka")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.activation_success_email.subject
  #
  def activation_success_email(user)
    @user = user
    @url  = "http://kucharka-pilot.herokuapp.com"
    mail(:to => user.email,
         :subject => "Účet aktivován")
  end
end
