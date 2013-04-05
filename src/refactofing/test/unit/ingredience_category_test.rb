# coding:utf-8

require 'test_helper'
require 'ingredience_category'

class IngredienceCategoryTest < ActiveSupport::TestCase

  ##############################################################################

  def test_create
    # vychazi z ni ostatni testy, tak abych vedel, ze to pada i bez uprav
    @newItem = IngredienceCategory.new(
      :name => "test",
      :description => "popisek ingredience o delce alespon 20",
      :category_type => 0,
      :user_id => 1)
    assert(@newItem.save, "Pokus o ulozeni nove kategorie")
  end

  def test_description_validation
    @newIngredience = ingredience_categories(:one)

    @newIngredience.description = nil
    assert(@newIngredience.save, "Pokus o ulozeni null popisu")

    @newIngredience.description = ""
    assert(@newIngredience.save, "Pokus o ulozeni prazdneho popisu")

    @newIngredience.description = "aaaaaaaaaa"
    assert(!@newIngredience.save, "Pokus o ulozeni popisu delky 10")

    @newIngredience.description = "aaaaaaaaa aaaaaaaaa aaaaaaaaa aaaaaaaaa aaaaaaaaa "
    assert(@newIngredience.save, "Pokus o ulozeni popisu delky 50")
  end

  def test_category_validation
    @newIngredience = ingredience_categories(:one)

    @newIngredience.category_type = 0
    assert(@newIngredience.save, "Pokus o ulozeni spravne kategorie")

    @newIngredience.category_type = -1
    assert(!@newIngredience.save, "Pokus o ulozeni typu kategorie < 0")

    @newIngredience.category_type = nil
    assert(!@newIngredience.save, "Pokus o ulozeni null typu kategorie")
  end

  def test_user_validation
    @newIngredience = ingredience_categories(:one)

    @newIngredience.user_id = 1
    assert(@newIngredience.save, "Pokus o ulozeni uzivatele s ID 1")

    @newIngredience.user_id = 0
    assert(!@newIngredience.save, "Pokus o ulozeni uzivatele s ID 0")

    @newIngredience.user_id = nil
    assert(!@newIngredience.save, "Pokus o ulozeni NULL uzivatele")
  end
end
