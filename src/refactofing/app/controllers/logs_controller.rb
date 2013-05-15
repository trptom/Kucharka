class LogsController < ApplicationController
  before_filter :user_rights_filter

  def index
    @files = Array.new
#    @files << Rails.env + ".log"
    LOGGER.each_pair do |key, value|
      @files << (Rails.env + "_" + key.to_s + ".log")
    end
  end

  def show
    @lines = Array.new
    File.open(Rails.root.join("log", params[:file]), "r").each_line do |line|
      @lines << line
    end
  end

  def detail
    @lines = Array.new
    File.open(Rails.root.join("log", params[:file]), "r").each_line do |line|
      @lines << line
    end
  end
end
