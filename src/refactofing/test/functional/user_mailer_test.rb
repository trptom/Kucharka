# coding:utf-8

require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "activation_needed_email" do
    mail = UserMailer.activation_needed_email(users(:one))
    assert_equal "Vítejte v aplikaci Kuchařka", mail.subject
    assert_equal [users(:one).email], mail.to
    assert_equal ["info@kucharka.com"], mail.from
    assert_match "Úspěšně jste se zaregistroval(a)", mail.body.encoded
  end

  test "activation_success_email" do
    mail = UserMailer.activation_success_email(users(:one))
    assert_equal "Účet aktivován", mail.subject
    assert_equal [users(:one).email], mail.to
    assert_equal ["info@kucharka.com"], mail.from
    assert_match "Úspěšně jste aktivoval(a) svůj účet", mail.body.encoded
  end

  test "reset_password_email" do
    mail = UserMailer.reset_password_email
    assert_equal "Reset password email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
