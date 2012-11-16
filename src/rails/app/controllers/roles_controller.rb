# To change this template, choose Tools | Templates
# and open the template in the editor.

class RolesController < ApplicationController
  def index
    @roles = Role.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @roles }
    end
  end
end
