# coding:utf-8

class MarksController < ApplicationController
  before_filter :user_rights_filter

  def index
    @marks = Mark.all
  end

  def create
    @recipe = Recipe.find(params["recipe"])
    @mark = @recipe.marks.where(:user_id => current_user.id).first;
    
    if !@mark
      @mark = Mark.new
      @mark.recipe = @recipe
      @mark.user = current_user
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
  rescue ActiveRecord::RecordNotFound
    redirect_to "/home/error"#, notice: "Recept s daným ID neexistuje"
  end

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
