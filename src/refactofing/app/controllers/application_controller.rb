# pro vsechny controllery chci mit aplikacni helper
include ApplicationHelper
include PermissionsHelper
include LayoutHelper

class ApplicationController < ActionController::Base

  layout :layout

  protect_from_forgery

end