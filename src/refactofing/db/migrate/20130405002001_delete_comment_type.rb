# coding:utf-8

class DeleteCommentType < ActiveRecord::Migration
  def self.up
    remove_column :comments, :comment_type
  end

  def self.down
    add_column :comments, :comment_type, :integer, :null => false
  end
end
