class RecipeArticleLinksController < ApplicationController
  # GET /recipe_article_links
  # GET /recipe_article_links.json
  def index
    @recipe_article_links = RecipeArticleLink.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recipe_article_links }
    end
  end

  # GET /recipe_article_links/1
  # GET /recipe_article_links/1.json
  def show
    @recipe_article_link = RecipeArticleLink.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recipe_article_link }
    end
  end

  # GET /recipe_article_links/new
  # GET /recipe_article_links/new.json
  def new
    @recipe_article_link = RecipeArticleLink.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recipe_article_link }
    end
  end

  # GET /recipe_article_links/1/edit
  def edit
    @recipe_article_link = RecipeArticleLink.find(params[:id])
  end

  # POST /recipe_article_links
  # POST /recipe_article_links.json
  def create
    @recipe_article_link = RecipeArticleLink.new(params[:recipe_article_link])

    respond_to do |format|
      if @recipe_article_link.save
        format.html { redirect_to @recipe_article_link, notice: 'Recipe article link was successfully created.' }
        format.json { render json: @recipe_article_link, status: :created, location: @recipe_article_link }
      else
        format.html { render action: "new" }
        format.json { render json: @recipe_article_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recipe_article_links/1
  # PUT /recipe_article_links/1.json
  def update
    @recipe_article_link = RecipeArticleLink.find(params[:id])

    respond_to do |format|
      if @recipe_article_link.update_attributes(params[:recipe_article_link])
        format.html { redirect_to @recipe_article_link, notice: 'Recipe article link was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recipe_article_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipe_article_links/1
  # DELETE /recipe_article_links/1.json
  def destroy
    @recipe_article_link = RecipeArticleLink.find(params[:id])
    @recipe_article_link.destroy

    respond_to do |format|
      format.html { redirect_to recipe_article_links_url }
      format.json { head :no_content }
    end
  end
end
