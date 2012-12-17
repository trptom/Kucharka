# pro vsechny controllery chci mit aplikacni helper
require "#{Rails.root}/app/helpers/application_helper"
require "#{Rails.root}/app/helpers/permissions_helper"
include ApplicationHelper
include PermissionsHelper

class ApplicationController < ActionController::Base

  protect_from_forgery

end