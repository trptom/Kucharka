# coding:utf-8

require 'test_helper'
require 'user'

class UserTest < ActiveSupport::TestCase
  def test_create_and_activate
    @user = User.new(
      :username => "trptom",
      :email => "nonexistingemail@idontwanttosendmails.cz",
      :password => "aaabbb",
      :password_confirmation => "aaabbb",
      :note => "TEST")
    assert(@user.save, "Ulozeni noveho uzivatele")
    assert(@user.activate!, "Aktivace noveho uzivatele")
    assert(@user.active, "Kontrola, zda novy uzivatel je aktivni")
  end

  def test_email_validation
    @user = users(:one)

    @user.email = "nonexistingemail@idontwanttosendmails.cz"
    assert(@user.save, "Ulozeni emailu ve spravnem formatu")

    @user.email = "nonexistingemail@idontwanttosendmails"
    assert(!@user.save, "Ulozeni emailu ve spatnem formatu #1")

    @user.email = "@mails.cz"
    assert(!@user.save, "Ulozeni emailu ve spatnem formatu #2")

    @user.email = "mails"
    assert(!@user.save, "Ulozeni emailu ve spatnem formatu #3")

    @user.email = "@."
    assert(!@user.save, "Ulozeni emailu ve spatnem formatu #4")

    @user.email = nil
    assert(!@user.save, "Ulozeni nuloveho emailu")

    @user.email = ""
    assert(!@user.save, "Ulozeni prazdneho emailu")
  end

  def test_username_validation
    @user = users(:one)

    @user.username = "..."
    assert(@user.save, "Ulozeni username ve spravnem formatu")

    @user.username = "trptom+"
    assert(!@user.save, "Ulozeni username ve spatnem formatu #1")

    @user.username = "zvlastni username"
    assert(!@user.save, "Ulozeni username ve spatnem formatu #2")

    @user.username = "zvlastni?username"
    assert(!@user.save, "Ulozeni username ve spatnem formatu #3")

    @user.username = "ab"
    assert(!@user.save, "Ulozeni kratkeho username (2 znaky)")

    @user.username = "1234567890123456789012345678901234567890"
    assert(!@user.save, "Ulozeni dlouheho username (40 znaku)")

    @user.username = nil
    assert(!@user.save, "Ulozeni nuloveho username")

    @user.username = ""
    assert(!@user.save, "Ulozeni prazdneho username")
  end

  def test_first_name_validation
    @user = users(:one)

    @user.first_name = "Bob"
    assert(@user.save, "Ulozeni first_name ve spravnem formatu")

    @user.first_name = "a"
    assert(!@user.save, "Ulozeni kratkeho first_name (1 znak)")

    @user.first_name = nil
    assert(@user.save, "Ulozeni nuloveho first_name")

    @user.first_name = ""
    assert(@user.save, "Ulozeni prazdneho first_name")
  end

  def test_first_name_validation
    @user = users(:one)

    @user.second_name = "Bobowski"
    assert(@user.save, "Ulozeni second_name ve spravnem formatu")

    @user.second_name = "a"
    assert(!@user.save, "Ulozeni kratkeho second_name (1 znak)")

    @user.second_name = nil
    assert(@user.save, "Ulozeni nuloveho second_name")

    @user.second_name = ""
    assert(@user.save, "Ulozeni prazdneho second_name")
  end

  def test_age_validation
    @user = users(:one)

    @user.age = 25
    assert(@user.save, "Ulozeni age ve spravnem formatu")

    @user.age = "25"
    assert(@user.save, "Ulozeni age jako string")

    @user.age = "25x"
    assert(!@user.save, "Ulozeni age jako string ve spatnem formatu")

    @user.age = -20
    assert(!@user.save, "Ulozeni age -20")

    @user.age = -200
    assert(!@user.save, "Ulozeni age 200")

    @user.age = nil
    assert(@user.save, "Ulozeni nuloveho age")

    @user.age = ""
    assert(@user.save, "Ulozeni prazdneho age")
  end

  def test_rules_self_validation
    @user = users(:one)

    @user.self_ruleset = 0
    assert(@user.save, "Ulozeni self_ruleset ve spravnem formatu")

    @user.self_ruleset = "0"
    assert(@user.save, "Ulozeni self_ruleset ajko spravny string")

    @user.self_ruleset = "a"
    assert(!@user.save, "Ulozeni self_ruleset ajko spatny string")

    @user.self_ruleset = nil
    assert(!@user.save, "Ulozeni nuloveho self_ruleset")

    @user.self_ruleset = ""
    assert(!@user.save, "Ulozeni prazdneho self_ruleset")
  end

  def test_rules_others_validation
    @user = users(:one)

    @user.others_ruleset = 0
    assert(@user.save, "Ulozeni others_ruleset ve spravnem formatu")

    @user.others_ruleset = "0"
    assert(@user.save, "Ulozeni others_ruleset ajko spravny string")

    @user.others_ruleset = "a"
    assert(!@user.save, "Ulozeni others_ruleset ajko spatny string")

    @user.others_ruleset = nil
    assert(!@user.save, "Ulozeni nuloveho others_ruleset")

    @user.others_ruleset = ""
    assert(!@user.save, "Ulozeni prazdneho others_ruleset")
  end

  def test_password_validation
    @user = users(:one)

    @user.password = "somepassword"
    @user.password_confirmation = "somepassword"
    assert(@user.save, "Ulozeni hesla ve spravnem formatu")

    @user.password = "somepassword"
    @user.password_confirmation = "somepassworderror"
    assert(!@user.save, "Ulozeni hesla se spatnym overovanim")

    @user.password = "so"
    @user.password_confirmation = "somepassword"
    assert(!@user.save, "Ulozeni kratkeho hesla se spatnym overovanim (ktere ma spravnou delku)")

    @user.password = "somepassword"
    @user.password_confirmation = "so"
    assert(!@user.save, "Ulozeni spravneho hesla se spatnym overovanim (ktere ma spatnou delku)")

    @user.password = "so"
    @user.password_confirmation = "so"
    assert(!@user.save, "Ulozeni hesla, ktere ma spatnou delku (vcetne overovani)")

    # nastaveni hesla, potom ulozeni nil hesla a potom prihlaseni pres puvodni
    # nil se nesmi ulozit, takze cely proces musi projit
#    @user.password = "pass"
#    @user.password_confirmation = "pass"
#    @user.save
#    @pass_before = @user.crypted_password
#    @salt_before = @user.salt
#    @old = Sorcery::CryptoProviders::BCrypt.encrypt("pass", @salt_before)
#
#    @user.password = "ni"
#    @user.password_confirmation = "ni"
#    @user.save
#    login_user_post(@user.username,"pass") # by default looks for @user
#    assert(current_user, "Overovani ukladani nil hesla #{@salt_before} >> #{@user.salt}")
#    logout_user
#
#    @user.password = nil
#    @user.password_confirmation = "ababab"
#    @user.save
#    assert(@user.crypted_password == @pass_before, "Overovani ukladani nil hesla se standardni confirmation")
#
#    @user.password = "ababab"
#    @user.password_confirmation = nil
#    @user.save
#    assert(@user.crypted_password == @pass_before, "Overovani ukladani standardniho hesla s nil confirmation")
  end
end
