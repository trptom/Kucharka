class IngredienceCategoriesController < ApplicationController
  before_filter :user_rights_filter

  # GET /ingredience_categories
  # GET /ingredience_categories.json
  def index
    @ingredience_categories = IngredienceCategory.all
  end

  # GET /ingredience_categories/1
  # GET /ingredience_categories/1.json
  def show
    @ingredience_category = IngredienceCategory.find(params[:id])
  end

  # GET /ingredience_categories/new
  # GET /ingredience_categories/new.json
  def new
    @ingredience_category = IngredienceCategory.new
  end

  # GET /ingredience_categories/1/edit
  def edit
    @ingredience_category = IngredienceCategory.find(params[:id])
  end

  # POST /ingredience_categories
  # POST /ingredience_categories.json
  def create
    @ingredience_category = IngredienceCategory.new(params[:ingredience_category])
    @ingredience_category.user = current_user

    if @ingredience_category.save
      redirect_to @ingredience_category, notice: 'Ingredience category was successfully created.'
    else
      @errors = @ingredience_category.errors
      render action: "new"
    end
  end

  # PUT /ingredience_categories/1
  # PUT /ingredience_categories/1.json
  def update
    @ingredience_category = IngredienceCategory.find(params[:id])

    if @ingredience_category.update_attributes(params[:ingredience_category])
      redirect_to @ingredience_category, notice: 'Ingredience category was successfully updated.'
    else
      @errors = @ingredience_category.errors
      render action: "edit"
    end
  end

  # DELETE /ingredience_categories/1
  # DELETE /ingredience_categories/1.json
  def destroy
    @ingredience_category = IngredienceCategory.find(params[:id])
    @ingredience_category.destroy

    redirect_to ingredience_categories_url
  end
end
