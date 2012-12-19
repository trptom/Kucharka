class HomeController < ApplicationController
  before_filter :user_rights_filter

  def index
    @newest = Recipe.order("created_at DESC").limit(2).all
    @season = Recipe.order("created_at DESC").limit(2).all
    @best = Recipe.order("created_at DESC").limit(2).all
  end

  def error
  end

  def success
  end
end
