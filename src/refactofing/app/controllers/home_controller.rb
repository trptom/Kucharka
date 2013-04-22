include RecipesHelper
include HomeHelper

class HomeController < ApplicationController
  before_filter :user_rights_filter

  def index
    @newest = get_recipes_sorted_by_date(5)
    @random = get_recipes_by_random(5)
    @best = get_recipes_by_mark(5)
  end

  def search
    @recipes = get_recipes_by_search(params);
    @articles = get_articles_by_search(params);

    if @recipes.is_a? String
      @recipes_note = @recipes
      @recipes = Array.new
    end
    if @articles.is_a? String
      @articles_note = @articles
      @articles = Array.new
    end
  end

  def error
  end

  def success
  end
end
