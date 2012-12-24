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
    @recipe = Recipe.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recipe }
    end
  end

  def create
    @recipe = Recipe.new(params[:recipe])
    @recipe.user = current_user

    @cat = RecipeCategory.new
    @cat.name = "Nova kategorie"
    @cat.user = current_user
    @cat.save
    @recipe.recipeCategories << @cat

    @article = Article.new()
    @article.user = current_user
    @article.title = "Automaticky generovany clanek"
    @article.annotation = "Nejaka ta anotace"
    @article.content = "A taky obsah: " + @recipe.content
    @article.save

    @ingredience = Ingredience.find(1)
    @ir = IngredienceRecipeConnector.new
    @ir.ingredience = @ingredience
    @ir.importance = 10;
    @ir.quantity = 5
    @recipe.ingredienceRecipeConnectors << @ir
    
    @recipe.articles << @article

    respond_to do |format|
      if @recipe.save
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

    respond_to do |format|
      if @recipe.update_attributes(params[:recipe])
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
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
end