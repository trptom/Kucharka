# coding:utf-8

class CommentsController < ApplicationController
  before_filter :user_rights_filter

  # POST /comments
  # POST /comments.json
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

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    if @comment.update_attributes(params[:comment])
      redirect_to @comment, notice: 'Comment was successfully updated.'
    else
      @errors = @comment.errors
      render action: "edit"
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to :back
  end
end
