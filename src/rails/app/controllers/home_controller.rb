require "#{Rails.root}/app/helpers/recipes_helper"
include RecipesHelper

class HomeController < ApplicationController
  before_filter :user_rights_filter

  def index
    @newest = get_recipes_sorted_by_date(5)
    @season = get_recipes_by_random(3)
    @best = Recipe.order("created_at DESC").limit(2).all
  end

  def error
  end

  def success
  end
end
