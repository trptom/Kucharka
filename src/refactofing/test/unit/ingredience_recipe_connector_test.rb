# coding:utf-8

require 'test_helper'
require 'ingredience_recipe_connector'

class IngredienceRecipeConnectorTest < ActiveSupport::TestCase
  
  def test_create
    # vychazi z ni ostatni testy, tak abych vedel, ze to pada i bez uprav
    @newItem = IngredienceRecipeConnector.new
    @newItem.recipe = recipes(:one)
    @newItem.ingredience = ingrediences(:one)
    @newItem.quantity = 1
    @newItem.importance = 1
    assert(@newItem.save, "Pokus o ulozeni noveho connectoru")
  end

  def test_quantity_validation
    @item = ingredience_recipe_connectors(:one)

    @item.quantity = nil
    assert(!@item.save, "Pokus o ulozeni null quantity")

    @item.quantity = 0
    assert(!@item.save, "Pokus o ulozeni quantity hodnoty 0")

    @item.quantity = "1"
    assert(@item.save, "Pokus o ulozeni quantity jako string ve spravnem formatu")

    @item.quantity = "wrong"
    assert(!@item.save, "Pokus o ulozeni quantity jako string ve spatnem formatu")

    @item.quantity = 999999.9
    assert(@item.save, "Pokus o ulozeni quantity hodnoty 999999.9")
  end

  def test_importance_validation
    @item = ingredience_recipe_connectors(:one)

    @item.importance = nil
    assert(!@item.save, "Pokus o ulozeni NULL dulezitosti")
    
    @item.importance = 0
    assert(!@item.save, "Pokus o ulozeni dulezitosti 0")

    @item.importance = "1"
    assert(@item.save, "Pokus o ulozeni dulezitosti jako string ve spravnem formatu")

    @item.importance = "wrong"
    assert(!@item.save, "Pokus o ulozeni dulezitosti jako string ve spatnem formatu")

    @item.importance = 10000
    assert(!@item.save, "Pokus o ulozeni dulezitosti > 1000")
  end
end
