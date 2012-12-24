# coding:utf-8

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

  def create
    @mark = Mark.where(:recipe_id => params["recipe"]).where(:user_id => current_user.id).first;
    if (@mark == nil)
      @new = true
      @mark = Mark.new
      @mark.recipe_id = params["recipe"].to_i
      @mark.user_id = current_user.id
      @mark.value = params["value"].to_i
    else
      @mark.value = params["value"].to_i
      @new = false
    end

    if @new
      if !(@mark.save!)
        redirect_to "/home/error", notice: "známku se nepodařilo vložit"
      end
    else
      if !(@mark.update_attribute(:value, params["value"].to_i))
        redirect_to "/home/error", notice: "známku se nepodařilo aktualizovat"
      end
    end

    redirect_to recipe_path(@mark.recipe_id)
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
