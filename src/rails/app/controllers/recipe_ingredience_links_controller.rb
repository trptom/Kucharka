class RecipeIngredienceLinksController < ApplicationController
  # GET /recipe_ingredience_links
  # GET /recipe_ingredience_links.json
  def index
    @recipe_ingredience_links = RecipeIngredienceLink.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recipe_ingredience_links }
    end
  end

  # GET /recipe_ingredience_links/1
  # GET /recipe_ingredience_links/1.json
  def show
    @recipe_ingredience_link = RecipeIngredienceLink.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recipe_ingredience_link }
    end
  end

  # GET /recipe_ingredience_links/new
  # GET /recipe_ingredience_links/new.json
  def new
    @recipe_ingredience_link = RecipeIngredienceLink.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recipe_ingredience_link }
    end
  end

  # GET /recipe_ingredience_links/1/edit
  def edit
    @recipe_ingredience_link = RecipeIngredienceLink.find(params[:id])
  end

  # POST /recipe_ingredience_links
  # POST /recipe_ingredience_links.json
  def create
    @recipe_ingredience_link = RecipeIngredienceLink.new(params[:recipe_ingredience_link])

    respond_to do |format|
      if @recipe_ingredience_link.save
        format.html { redirect_to @recipe_ingredience_link, notice: 'Recipe ingredience link was successfully created.' }
        format.json { render json: @recipe_ingredience_link, status: :created, location: @recipe_ingredience_link }
      else
        format.html { render action: "new" }
        format.json { render json: @recipe_ingredience_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recipe_ingredience_links/1
  # PUT /recipe_ingredience_links/1.json
  def update
    @recipe_ingredience_link = RecipeIngredienceLink.find(params[:id])

    respond_to do |format|
      if @recipe_ingredience_link.update_attributes(params[:recipe_ingredience_link])
        format.html { redirect_to @recipe_ingredience_link, notice: 'Recipe ingredience link was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recipe_ingredience_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipe_ingredience_links/1
  # DELETE /recipe_ingredience_links/1.json
  def destroy
    @recipe_ingredience_link = RecipeIngredienceLink.find(params[:id])
    @recipe_ingredience_link.destroy

    respond_to do |format|
      format.html { redirect_to recipe_ingredience_links_url }
      format.json { head :no_content }
    end
  end
end
