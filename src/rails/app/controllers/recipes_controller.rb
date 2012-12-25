# coding:utf-8

class RecipesController < ApplicationController
  before_filter :user_rights_filter

  def index
    @recipes = Recipe.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recipes }
    end
  end

  def show
    @recipe = Recipe.find(params[:id])

    # seznam komentaru pto recept
    @comments = Comment.where(:comment_type => COMMENT_TYPE['recipes'], :recipe_id => @recipe.id)

    # entita na pridani noveho komentare
    @comment = Comment.new
    @comment.comment_type = COMMENT_TYPE['recipes']
    @comment.user = current_user
    @comment.recipe = @recipe

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recipe }
    end
  end

  def new
    #nastaveni textaci
    @title = "Nový recept"
    @submit_title = "Vytvořit recept"

    @recipe = Recipe.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recipe }
    end
  end

  def create
    @recipe = Recipe.new(params[:recipe])
    @recipe.user = current_user

    @saved = false
    ActiveRecord::Base.transaction do
      @recipe.ingredienceRecipeConnectors = get_ingrediences_ary_from_params(nil)
      @saved = @recipe.save
    end

    respond_to do |format|
      if @saved
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render json: @recipe, status: :created, location: @recipe }
      else
        format.html { render action: "new" }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @recipe = Recipe.find(params[:id])

    @saved = true
    ActiveRecord::Base.transaction do
      if !@recipe.update_attributes(params[:recipe])
        @saved = false;
      end
      @recipe.ingredienceRecipeConnectors = get_ingrediences_ary_from_params(@recipe.id)
      if !@recipe.save
        @saved = false;
      end
    end

    respond_to do |format|
      if @saved
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    #nastaveni textaci
    @title = "Editace receptu"
    @submit_title = "Upravit recept"

    @recipe = Recipe.find(params[:id])
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url }
      format.json { head :no_content }
    end
  end

  def fridge
    @recipes = get_recipes_by_fridge(params)
  end

  def newest
    @recipes = Recipe.get_recipes_sorted_by_date(params[:count] == nil ? 10 : params[:count].to_i)
  end

  def add_subrecipe
    @msg = "false";
    if params[:parent_recipe_id] != nil && params[:child_recipe_id] != nil
      @child_recipe = Recipe.find(params[:child_recipe_id])
      @parent_recipe = Recipe.find(params[:parent_recipe_id])
      if (@child_recipe != nil && @parent_recipe != nil)
        #TODO
      end
    end
  end

  def add_connected_article
    @msg = "false";
    if params[:id] != nil && params[:article_id] != nil
      @recipe = Recipe.find(params[:id])
      @article = Article.find(params[:article_id])
      if (@recipe != nil && @article != nil)
        @recipe.articles << @article
        if @recipe.save
          @msg = "true"
        end
      end
    end
  end
end