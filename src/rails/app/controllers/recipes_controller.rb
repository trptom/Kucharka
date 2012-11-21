# coding:utf-8

class RecipesController < ApplicationController
  def index
    @recipes = session[:recipes] ? session[:recipes] : Recipe.all
    session[:recipes] = nil

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recipes }
    end
  end

  def show

  end

  def new

  end

  def create

  end

  def edit

  end

  def destroy
    
  end
end