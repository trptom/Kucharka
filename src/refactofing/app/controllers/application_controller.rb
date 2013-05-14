# pro vsechny controllery chci mit aplikacni helper
include ApplicationHelper
include PermissionsHelper
include LayoutHelper

class ApplicationController < ActionController::Base
  layout :layout

  protect_from_forgery

  def log_page_request

    LOGGER[:page_requests].info get_log_prefix + "page \"" + get_current_url + "\" requested (" + params.to_s + ")";
  end

  before_filter :log_page_request
end