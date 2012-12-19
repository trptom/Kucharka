class IngredienceCategoriesController < ApplicationController
  before_filter :user_rights_filter

  # GET /ingredience_categories
  # GET /ingredience_categories.json
  def index
    @ingredience_categories = IngredienceCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ingredience_categories }
    end
  end

  # GET /ingredience_categories/1
  # GET /ingredience_categories/1.json
  def show
    @ingredience_category = IngredienceCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ingredience_category }
    end
  end

  # GET /ingredience_categories/new
  # GET /ingredience_categories/new.json
  def new
    @ingredience_category = IngredienceCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ingredience_category }
    end
  end

  # GET /ingredience_categories/1/edit
  def edit
    @ingredience_category = IngredienceCategory.find(params[:id])
  end

  # POST /ingredience_categories
  # POST /ingredience_categories.json
  def create
    @ingredience_category = IngredienceCategory.new(params[:ingredience_category])

    respond_to do |format|
      if @ingredience_category.save
        format.html { redirect_to @ingredience_category, notice: 'Ingredience category was successfully created.' }
        format.json { render json: @ingredience_category, status: :created, location: @ingredience_category }
      else
        format.html { render action: "new" }
        format.json { render json: @ingredience_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ingredience_categories/1
  # PUT /ingredience_categories/1.json
  def update
    @ingredience_category = IngredienceCategory.find(params[:id])

    respond_to do |format|
      if @ingredience_category.update_attributes(params[:ingredience_category])
        format.html { redirect_to @ingredience_category, notice: 'Ingredience category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ingredience_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredience_categories/1
  # DELETE /ingredience_categories/1.json
  def destroy
    @ingredience_category = IngredienceCategory.find(params[:id])
    @ingredience_category.destroy

    respond_to do |format|
      format.html { redirect_to ingredience_categories_url }
      format.json { head :no_content }
    end
  end
end
