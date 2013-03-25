# coding:utf-8

class RecipeRecipeConnector < ActiveRecord::Base
  belongs_to :recipe,
    :class_name => 'Recipe', :foreign_key => 'recipe_id'
  belongs_to :subrecipe,
    :class_name => 'Recipe', :foreign_key => 'subrecipe_id'

  attr_accessible :recipe_id, :subrecipe_id
end
