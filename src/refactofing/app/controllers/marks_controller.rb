# coding:utf-8

class MarksController < ApplicationController
  before_filter :user_rights_filter

  # GET /marks
  # GET /marks.json
  def index
    @marks = Mark.all
  end

  def create
    @mark = Mark.where(:recipe_id => params["recipe"]).where(:user_id => current_user.id).first;
    
    if (@mark == nil)
      @mark = Mark.new
      @mark.recipe_id = params["recipe"].to_i
      @mark.user_id = current_user.id
      @mark.value = params["value"].to_i
      @mark.save
    else
      @mark.value = params["value"].to_i
      @mark.update_attribute(:value, params["value"].to_i)
    end

    respond_to do |format|
      format.html { redirect_to @mark.recipe }
      format.json {
        @res = Hash.new
        @res["total"] = get_mark_str(@mark.recipe)
        @res["my"] = @mark.value
        render json: @res
      }
    end
  end

  # DELETE /marks/1
  # DELETE /marks/1.json
  def destroy
    @mark = Mark.find(params[:id])
    @recipe = @mark.recipe
    @mark.destroy

    respond_to do |format|
      format.html { redirect_to "/marks" }
      format.json {
        @res = Hash.new
        @res["total"] = get_mark_str(@recipe)
        @res["my"] = ""
        render json: @res
      }
    end
  end
end
