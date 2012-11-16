# pro vsechny controllery chci mit aplikacni helper
require "#{Rails.root}/app/helpers/application_helper"
include ApplicationHelper

class ApplicationController < ActionController::Base
  include TheRole::Requires # pracuju s rolemi

  protect_from_forgery

  def require_role # funkce validujici role
    if role_required
      return true
    else
      redirect_to "/422.html"
    end
  end

  def require_login # funkce validujici, zda je uzivatel prihlasen
    if (current_user != nil)
      return true
    else
      redirect_to login_path, :alert => "Please login first."
    end
  end

  def require_user_id(allow)
    if (allow || current_user.id.to_s == params[:id])
      return true
    else
      redirect_to "/422.html"
    end
  end

  def do_nothing
  end

  alias_method :role_access_denied, :do_nothing # aby se mi to nepresmerovavalo na home
end