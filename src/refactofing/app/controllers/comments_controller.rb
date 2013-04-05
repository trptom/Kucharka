# coding:utf-8

class CommentsController < ApplicationController
  before_filter :user_rights_filter

  def create
    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to :back
    else
      @errors = @comment.errors
      redirect_to :back, notice: "Komentář se nepodařilo přidat!"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to :back
  end
end
