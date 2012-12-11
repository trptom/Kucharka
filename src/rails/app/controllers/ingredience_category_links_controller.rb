class IngredienceCategoryLinksController < ApplicationController
  # GET /ingredience_category_links
  # GET /ingredience_category_links.json
  def index
    @ingredience_category_links = IngredienceCategoryLink.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ingredience_category_links }
    end
  end

  # GET /ingredience_category_links/1
  # GET /ingredience_category_links/1.json
  def show
    @ingredience_category_link = IngredienceCategoryLink.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ingredience_category_link }
    end
  end

  # GET /ingredience_category_links/new
  # GET /ingredience_category_links/new.json
  def new
    @ingredience_category_link = IngredienceCategoryLink.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ingredience_category_link }
    end
  end

  # GET /ingredience_category_links/1/edit
  def edit
    @ingredience_category_link = IngredienceCategoryLink.find(params[:id])
  end

  # POST /ingredience_category_links
  # POST /ingredience_category_links.json
  def create
    @ingredience_category_link = IngredienceCategoryLink.new(params[:ingredience_category_link])

    respond_to do |format|
      if @ingredience_category_link.save
        format.html { redirect_to @ingredience_category_link, notice: 'Ingredience category link was successfully created.' }
        format.json { render json: @ingredience_category_link, status: :created, location: @ingredience_category_link }
      else
        format.html { render action: "new" }
        format.json { render json: @ingredience_category_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ingredience_category_links/1
  # PUT /ingredience_category_links/1.json
  def update
    @ingredience_category_link = IngredienceCategoryLink.find(params[:id])

    respond_to do |format|
      if @ingredience_category_link.update_attributes(params[:ingredience_category_link])
        format.html { redirect_to @ingredience_category_link, notice: 'Ingredience category link was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ingredience_category_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredience_category_links/1
  # DELETE /ingredience_category_links/1.json
  def destroy
    @ingredience_category_link = IngredienceCategoryLink.find(params[:id])
    @ingredience_category_link.destroy

    respond_to do |format|
      format.html { redirect_to ingredience_category_links_url }
      format.json { head :no_content }
    end
  end
end
