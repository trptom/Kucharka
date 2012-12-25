# pro vsechny controllery chci mit aplikacni helper
require "#{Rails.root}/app/helpers/application_helper"
require "#{Rails.root}/app/helpers/permissions_helper"
require "#{Rails.root}/app/helpers/layout_helper"
include ApplicationHelper
include PermissionsHelper
include LayoutHelper

class ApplicationController < ActionController::Base

  layout :layout

  protect_from_forgery

end