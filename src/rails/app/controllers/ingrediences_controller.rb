class IngrediencesController < ApplicationController
  before_filter :user_rights_filter

  # GET /ingrediences
  # GET /ingrediences.json
  def index
    @ingrediences_accepted = Ingredience.where(:activation_state => 1).all
    @ingrediences_pending = Ingredience.where(:activation_state => 0).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ingrediences }
    end
  end

  # GET /ingrediences/1
  def show
    @ingredience = Ingredience.find(params[:id])

    # seznam komentaru pro clanek
    @comments = Comment.where(:comment_type => COMMENT_TYPE['ingrediences'], :ingredience_id => @ingredience.id)

    # entita na pridani noveho komentare
    @comment = Comment.new
    @comment.comment_type = COMMENT_TYPE['ingrediences']
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
      render action: "new"
    end
  end

  # PUT /ingrediences/1
  def update
    @ingredience = Ingredience.find(params[:id])

    if @ingredience.update_attributes(params[:ingredience])
      redirect_to @ingredience, notice: 'Ingredience was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /ingrediences/1
  def destroy
    @ingredience = Ingredience.find(params[:id])
    @ingredience.destroy

    redirect_to ingrediences_url
  end

  def new_request
    @ingredience = Ingredience.new
    @ingredience.name = params[:name]
    @ingredience.units = params[:units]
    @ingredience.annotation = params[:annotation]
    @ingredience.content = params[:content]
    @ingredience.user = current_user

    if @ingredience.save
      @msg = "true"
    else
      @msg = "false"
    end

    redirect_to "/home/plain_message", notice: @msg
  end

  def plain_list
    @ingrediences = Ingredience.order(:name).all
  end
end
