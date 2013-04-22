# coding:utf-8

require 'cgi'
include RecipesHelper

class RecipesController < ApplicationController
  before_filter :user_rights_filter

  def show
    @recipe = Recipe.find(params[:id])

    if current_user
      @my_mark = @recipe.marks.where(:user_id => current_user.id).first
    end

    # seznam komentaru pto recept
    @comments = Comment.where(:recipe_id => @recipe.id)

    # entita na pridani noveho komentare
    @comment = Comment.new
    @comment.user = current_user
    @comment.recipe = @recipe

    # entity na propojeni
    @new_connected_article = RecipeRecipeConnector.new
    @new_connected_article.recipe_id = @recipe.id
    @new_subrecipe = RecipeRecipeConnector.new
    @new_subrecipe.recipe_id = @recipe.id
  end

  def new
    #nastaveni textaci
    @title = "Nový recept"
    @submit_title = "Vytvořit recept"

    @recipe = Recipe.new
    @categories = RecipeCategory.order(:name).all
  end

  def create
    @recipe = Recipe.new(params[:recipe])
    @recipe.user = current_user

    if @recipe.save
      redirect_to @recipe, notice: 'Recept byl úspěšně vytvořen.'
    else
      @errors = @recipe.errors
      render action: "new"
    end
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update_attributes(params[:recipe])
      redirect_to @recipe, notice: 'Recept byl úspěšně upraven.'
    else
      @errors = @recipe.errors
      render action: "edit"
    end
  end

  def edit
    #nastaveni textaci
    @title = "Editace receptu"
    @submit_title = "Upravit recept"

    @recipe = Recipe.find(params[:id])
    @categories = RecipeCategory.order(:name).all
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    redirect_to "/my_recipes"
  end

  def add_ingredience
    @recipe = Recipe.find(params[:id])
    params[:quantity] = params[:quantity].gsub ",", "."

    if params[:importance] && params[:quantity] && params[:quantity].to_f > 0 && params[:ingredience]
      if @recipe.ingrediences.where(:id => params[:ingredience]).length == 0
        @new_item = IngredienceRecipeConnector.new
        @new_item.importance = params[:importance].to_i
        @new_item.quantity = params[:quantity].to_f
        @new_item.recipe = @recipe
        @new_item.ingredience_id = params[:ingredience]
        @new_item.save
      else
        @item = @recipe.ingredienceRecipeConnectors.where(:ingredience_id => params[:ingredience]).first
        @item.quantity += params[:quantity].to_f
        @item.importance = params[:importance].to_i
        @item.save
      end
    end

    respond_to do |format|
      format.html { redirect_to @recipe }
      format.json {
        render json: @recipe.ingrediences
      }
    end
  end

  def remove_ingredience
    @recipe = Recipe.find(params[:id])

    if params[:connector_id]
      @to_remove = IngredienceRecipeConnector.find(params[:connector_id])
      @to_remove.destroy
    end

    respond_to do |format|
      format.html { redirect_to @recipe }
      format.json {
        render json: @recipe.ingrediences
      }
    end
  end

  def add_category
    @recipe = Recipe.find(params[:id])

    if params[:category] && @recipe.recipeCategories.where(:id => params[:category]).length == 0
      @recipe.recipeCategories << RecipeCategory.find(params[:category])
      @recipe.save
    end

    respond_to do |format|
      format.html { redirect_to @recipe }
      format.json {
        render json: @recipe.categories
      }
    end
  end

  def remove_category
    @recipe = Recipe.find(params[:id])

    if params[:category]
      @recipe.recipeCategories.delete(RecipeCategory.find(params[:category]))
    end

    respond_to do |format|
      format.html { redirect_to @recipe }
      format.json {
        render json: @recipe.recipeCategories
      }
    end
  end

  def add_subrecipe
    @recipe = Recipe.find(params[:id])

    if params[:subrecipe]
      @tmp = params[:subrecipe].split(/http.?\:\/\/[^\/]+\/recipes?\//)
      if @tmp.length == 2
        @msg = @tmp
        @id = @tmp[1].to_i
        if @id && @recipe.subrecipes.where(:id => @id).length == 0
          @new_item = RecipeRecipeConnector.new
          @new_item.recipe_id = params[:id]
          @new_item.subrecipe_id = @id
          @new_item.save
        end
      end
    end

    respond_to do |format|
      format.html { redirect_to @recipe }
      format.json {
        render json: @recipe.subrecipes
      }
    end
  end

  def remove_subrecipe
    @recipe = Recipe.find(params[:id])

    if params[:subrecipe]
      RecipeRecipeConnector.where(:recipe_id => params[:id]).where(:subrecipe_id => params[:subrecipe]).all? { |e| e.delete }
    end

    respond_to do |format|
      format.html { redirect_to @recipe }
      format.json {
        render json: @recipe.subrecipes
      }
    end
  end

  def add_connected_article
    @recipe = Recipe.find(params[:id])

    if params[:article]
      @tmp = params[:article].split(/http.?\:\/\/[^\/]+\/articles?\//)
      if @tmp.length == 2
        @msg = @tmp
        @id = @tmp[1].to_i
        if @id && @recipe.articles.where(:id => @id).length == 0
          @recipe.articles << Article.find(@id)
        end
      end
    end

    respond_to do |format|
      format.html { redirect_to @recipe }
      format.json {
        render json: @recipe.articles
      }
    end
  end

  def remove_connected_article
    @recipe = Recipe.find(params[:id])

    if params[:article]
      @recipe.articles.delete(Article.find(params[:article]))
    end

    respond_to do |format|
      format.html { redirect_to @recipe }
      format.json {
        render json: @recipe.articles
      }
    end
  end

  def fridge
    @ingrediences = Hash.new
    @ingrediences[:accepted] = Ingredience.where(:activation_state => 1).order(:name).all
    @ingrediences[:not_accepted] = Ingredience.where(:activation_state => 0).order(:name).all

    @fridge_result = get_recipes_by_fridge(params)
    @recipes = @fridge_result ? @fridge_result[:recipes] : []
    @badges = @fridge_result ? @fridge_result[:badges] : []
  end

  def filter
    @recipes = get_recipes_by_filter(params[:filter])
  end

  def newest
    @recipes = Recipe.get_recipes_sorted_by_date(params[:count] == nil ? 10 : params[:count].to_i)
  end
end