require "#{Rails.root}/app/helpers/recipes_helper"
include RecipesHelper

class HomeController < ApplicationController
  before_filter :user_rights_filter

  def index
    @newest = get_recipes_sorted_by_date(5)
    @random = get_recipes_by_random(5)
    @best = get_recipes_by_mark(5)
  end

  def error
  end

  def success
  end
end
