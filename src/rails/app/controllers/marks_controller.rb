# coding:utf-8

class MarksController < ApplicationController
  before_filter :user_rights_filter

  # GET /marks
  # GET /marks.json
  def index
    @marks = Mark.all
  end

  def create
    @msg = "true"
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
        @msg = "false"
      end
    else
      if !(@mark.update_attribute(:value, params["value"].to_i))
        @msg = "false"
      end
    end

    if @msg == "true" && marks_filter("show", nil, nil)
      @msg += "\n" + get_mark_str(@mark.recipe)
      @msg += "\n" + @mark.value.to_s
    end

    redirect_to "/home/plain_message", notice: @msg
  end

  # DELETE /marks/1
  # DELETE /marks/1.json
  def destroy
    @mark = Mark.find(params[:id])
    @mark.destroy

    redirect_to marks_url
  end
end
