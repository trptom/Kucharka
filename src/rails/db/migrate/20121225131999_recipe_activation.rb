# To change this template, choose Tools | Templates
# and open the template in the editor.

class RecipeActivation < ActiveRecord::Migration
  def self.up
    add_column :ingrediences, :activation_state, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :ingrediences, :activation_state
  end
end
