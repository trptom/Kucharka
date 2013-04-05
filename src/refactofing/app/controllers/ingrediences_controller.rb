class IngrediencesController < ApplicationController
  before_filter :user_rights_filter

  # GET /ingrediences
  # GET /ingrediences.json
  def index
    @ingrediences_accepted = Ingredience.where(:activation_state => 1).order(:name).all
    @ingrediences_pending = Ingredience.where(:activation_state => 0).order(:name).all

    respond_to do |format|
      format.html
      format.json {
        @tmp = Array.new
        @tmp << @ingrediences_accepted
        @tmp << @ingrediences_pending
        render json: @tmp
      }
    end
  end

  # GET /ingrediences/1
  def show
    @ingredience = Ingredience.find(params[:id])

    # seznam komentaru pro clanek
    @comments = Comment.where(:ingredience_id => @ingredience.id)

    # entita na pridani noveho komentare
    @comment = Comment.new
    @comment.user = current_user
    @comment.ingredience = @ingredience
  end

  # GET /ingrediences/new
  def new
    @ingredience = Ingredience.new
  end

  # GET /ingrediences/1/edit
  def edit
    @ingredience = Ingredience.find(params[:id])
  end

  # POST /ingrediences
  def create
    @ingredience = Ingredience.new(params[:ingredience])
    @ingredience.user = current_user

    if @ingredience.save
      redirect_to @ingredience, notice: 'Ingredience was successfully created.'
    else
      @errors = @ingredience.errors
      render action: "new"
    end
  end

  # PUT /ingrediences/1
  def update
    @ingredience = Ingredience.find(params[:id])

    if @ingredience.update_attributes(params[:ingredience])
      redirect_to @ingredience, notice: 'Ingredience was successfully updated.'
    else
      @errors = @ingredience.errors
      render action: "edit"
    end
  end

  # DELETE /ingrediences/1
  def destroy
    @ingredience = Ingredience.find(params[:id])
    @ingredience.destroy

    redirect_to ingrediences_url
  end
end
