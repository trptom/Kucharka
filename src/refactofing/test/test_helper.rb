# coding:utf-8

require 'simplecov'
SimpleCov.start do
  # odfiltruju testy, aby mi to nekazilo celkovy vysledky
  add_filter "test/"
  # taky vyhodim config - vzdy se projedou cele
  add_filter "config/"
  
  # zakladni skupiny podle typu souboru
  add_group "Models", "app/models"
  add_group "Controllers", "app/controllers"
  add_group "Mailers", "app/mailers"
  add_group "Uploaders", "app/uploaders"
  add_group "Helpers", "app/helpers"
  # a jeste neco navic
  add_group "Long files (200+)" do |src_file|
    src_file.lines.count > 200
  end
  add_group "Short files (10-)" do |src_file|
    src_file.lines.count <= 10
  end
end

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

include Sorcery::TestHelpers::Rails

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
end