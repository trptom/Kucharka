class UserMailer < ActionMailer::Base
  default from: "info@kucharka.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.activation_needed_email.subject
  #
  def activation_needed_email(user)
    @user = user
    @url  = "/users/#{user.activation_token}/activate?src=email"
    mail(:to => user.email,
         :subject => "Welcome to Kucharka")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.activation_success_email.subject
  #
  def activation_success_email(user)
    @user = user
    @url  = "/"
    mail(:to => user.email,
         :subject => "Your account is now activated")
  end
end
