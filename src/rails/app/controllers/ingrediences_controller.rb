class IngrediencesController < ApplicationController
  # GET /ingrediences
  # GET /ingrediences.json
  def index
    @ingrediences = Ingredience.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ingrediences }
    end
  end

  # GET /ingrediences/1
  # GET /ingrediences/1.json
  def show
    @ingredience = Ingredience.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ingredience }
    end
  end

  # GET /ingrediences/new
  # GET /ingrediences/new.json
  def new
    @ingredience = Ingredience.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ingredience }
    end
  end

  # GET /ingrediences/1/edit
  def edit
    @ingredience = Ingredience.find(params[:id])
  end

  # POST /ingrediences
  # POST /ingrediences.json
  def create
    @ingredience = Ingredience.new(params[:ingredience])
    @ingredience.user = current_user

    respond_to do |format|
      if @ingredience.save
        format.html { redirect_to @ingredience, notice: 'Ingredience was successfully created.' }
        format.json { render json: @ingredience, status: :created, location: @ingredience }
      else
        format.html { render action: "new" }
        format.json { render json: @ingredience.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ingrediences/1
  # PUT /ingrediences/1.json
  def update
    @ingredience = Ingredience.find(params[:id])

    respond_to do |format|
      if @ingredience.update_attributes(params[:ingredience])
        format.html { redirect_to @ingredience, notice: 'Ingredience was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ingredience.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingrediences/1
  # DELETE /ingrediences/1.json
  def destroy
    @ingredience = Ingredience.find(params[:id])
    @ingredience.destroy

    respond_to do |format|
      format.html { redirect_to ingrediences_url }
      format.json { head :no_content }
    end
  end
end
