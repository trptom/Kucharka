class MarksController < ApplicationController
  before_filter :user_rights_filter

  # GET /marks
  # GET /marks.json
  def index
    @marks = Mark.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @marks }
    end
  end

  def create_mark
    @mark = Mark.where(:recipe_id => params["recipe"]).where(:user_id => current_user.id).first;
    if (@mark == nil)
      @new = true
      @mark = Mark.new
      @mark.recipe_id = params["recipe"]
      @mark.user_id = current_user.id
      @mark.value = params["value"]
    else
      @new = false
    end

    if @mark.save!
      if @new
        @state = "INSERTED"
      else
        @state = "UPDATED"
      end
    else
      @state = "ERROR"
    end
  end

  # DELETE /marks/1
  # DELETE /marks/1.json
  def destroy
    @mark = Mark.find(params[:id])
    @mark.destroy

    respond_to do |format|
      format.html { redirect_to marks_url }
      format.json { head :no_content }
    end
  end
end
