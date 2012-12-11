class RecipeCategoryLinksController < ApplicationController
  # GET /recipe_category_links
  # GET /recipe_category_links.json
  def index
    @recipe_category_links = RecipeCategoryLink.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recipe_category_links }
    end
  end

  # GET /recipe_category_links/1
  # GET /recipe_category_links/1.json
  def show
    @recipe_category_link = RecipeCategoryLink.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recipe_category_link }
    end
  end

  # GET /recipe_category_links/new
  # GET /recipe_category_links/new.json
  def new
    @recipe_category_link = RecipeCategoryLink.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recipe_category_link }
    end
  end

  # GET /recipe_category_links/1/edit
  def edit
    @recipe_category_link = RecipeCategoryLink.find(params[:id])
  end

  # POST /recipe_category_links
  # POST /recipe_category_links.json
  def create
    @recipe_category_link = RecipeCategoryLink.new(params[:recipe_category_link])

    respond_to do |format|
      if @recipe_category_link.save
        format.html { redirect_to @recipe_category_link, notice: 'Recipe category link was successfully created.' }
        format.json { render json: @recipe_category_link, status: :created, location: @recipe_category_link }
      else
        format.html { render action: "new" }
        format.json { render json: @recipe_category_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recipe_category_links/1
  # PUT /recipe_category_links/1.json
  def update
    @recipe_category_link = RecipeCategoryLink.find(params[:id])

    respond_to do |format|
      if @recipe_category_link.update_attributes(params[:recipe_category_link])
        format.html { redirect_to @recipe_category_link, notice: 'Recipe category link was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recipe_category_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipe_category_links/1
  # DELETE /recipe_category_links/1.json
  def destroy
    @recipe_category_link = RecipeCategoryLink.find(params[:id])
    @recipe_category_link.destroy

    respond_to do |format|
      format.html { redirect_to recipe_category_links_url }
      format.json { head :no_content }
    end
  end
end
