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

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #
  def reset_password_email(user)
    @user = user
    @url  = edit_password_reset_url(user.reset_password_token, :host => "kucharka-pilot.herokuapp.com")
    mail(:to => user.email,
         :subject => "Vaše heslo bylo resetováno")
  end
end
