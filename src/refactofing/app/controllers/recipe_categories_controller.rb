class RecipeCategoriesController < ApplicationController
  before_filter :user_rights_filter

  # GET /recipe_categories
  # GET /recipe_categories.json
  def index
    @recipe_categories = RecipeCategory.all
  end

  # GET /recipe_categories/1
  # GET /recipe_categories/1.json
  def show
    @recipe_category = RecipeCategory.find(params[:id])
  end

  # GET /recipe_categories/new
  # GET /recipe_categories/new.json
  def new
    @recipe_category = RecipeCategory.new
  end

  # GET /recipe_categories/1/edit
  def edit
    @recipe_category = RecipeCategory.find(params[:id])
  end

  # POST /recipe_categories
  # POST /recipe_categories.json
  def create
    @recipe_category = RecipeCategory.new(params[:recipe_category])
    @recipe_category.user = current_user

    if @recipe_category.save
      redirect_to @recipe_category, notice: 'Recipe category was successfully created.'
    else
      @errors = @recipe_category.errors
      render action: "new"
    end
  end

  # PUT /recipe_categories/1
  # PUT /recipe_categories/1.json
  def update
    @recipe_category = RecipeCategory.find(params[:id])

    if @recipe_category.update_attributes(params[:recipe_category])
      redirect_to @recipe_category, notice: 'Recipe category was successfully updated.'
    else
      @errors = @recipe_category.errors
      render action: "edit"
    end
  end

  # DELETE /recipe_categories/1
  # DELETE /recipe_categories/1.json
  def destroy
    @recipe_category = RecipeCategory.find(params[:id])
    @recipe_category.destroy

    redirect_to recipe_categories_url
  end
end
