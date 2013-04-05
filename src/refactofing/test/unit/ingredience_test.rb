# coding:utf-8

require 'test_helper'
require 'ingredience'

class IngredienceTest < ActiveSupport::TestCase

  ##############################################################################

  def test_create
    # vychazi z ni ostatni testy, tak abych vedel, ze to pada i bez uprav
    @newItem = Ingredience.new(
      :name => "test",
      :annotation => "anotace o delce alespon 50 nebo prazdna 1234567890 1234567890 1234567890 1234567890 ",
      :content =>
        "obsah o delce alespon 100 1234567890 1234567890 1234567890 1234567890 " +
        "1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 ",
      :avaliability => 1,
      :units => "kg",
      :user_id => users(:admin).id)
    assert(@newItem.save, "Pokus o ulozeni noveho clanku")
  end

  def test_name_validation
    @item = ingrediences(:one)

    @item.name = nil
    assert(!@item.save, "Pokus o ulozeni prazdneho nazvu")

    @item.name = ""
    assert(!@item.save, "Pokus o ulozeni prazdneho nazvu")

    @item.name = "aa"
    assert(!@item.save, "Pokus o ulozeni kratkeho nazvu")

    @item.name = "aaaaaaaaa aaaaaaaaa aaaaaaaaa aaaaaaaaa aaaaaaaaa a" # 51 znaku by nemelo projit
    assert(!@item.save, "Pokus o ulozeni dlouheho nazvu ")
  end

  def test_annotation_validation
    @item = ingrediences(:one)

    @item.annotation = nil
    assert(@item.save, "Pokus o ulozeni null anotace")

    @item.annotation = ""
    assert(@item.save, "Pokus o ulozeni prazdne anotace")

    @item.annotation = "short"
    assert(!@item.save, "Pokus o ulozeni kratke anotace")

    annotation = ""
    for x in 0..50
      annotation += "extra long extra long extra long extra long extra long ";
    end
    @item.annotation =  annotation
    assert(!@item.save, "Pokus o ulozeni dlouhe anotace")
  end

  def test_content_validation
    @item = ingrediences(:one)

    @item.content = nil
    assert(@item.save, "Pokus o ulozeni null obsahu")

    @item.content = ""
    assert(@item.save, "Pokus o ulozeni prazdneho obsahu")

    @item.content = "short"
    assert(!@item.save, "Pokus o ulozeni kratkeho obsahu")

    content = ""
    for x in 0..100
      content += "extra long extra long extra long extra long extra long ";
    end
    @item.content =  content
    assert(@item.save, "Pokus o ulozeni hodne dlouheho obsahu (melo by projit)")
  end

  def test_avaliability_validation
    @item = ingrediences(:one)

    @item.avaliability = nil
    assert(!@item.save, "Pokus o ulozeni null dostupnosti")

    @item.avaliability = "1"
    assert(@item.save, "Pokus o ulozeni dostupnosti jako spravny string")

    @item.avaliability = "wrong"
    assert(!@item.save, "Pokus o ulozeni dostupnosti jako spatny string")

    @item.avaliability = 0
    assert(!@item.save, "Pokus o ulozeni dostupnosti < 1")

    @item.avaliability = 1001
    assert(!@item.save, "Pokus o ulozeni dostupnosti > 1000")
  end

  def test_units_validation
    @item = ingrediences(:one)

    @item.units = nil
    assert(!@item.save, "Pokus o ulozeni null jednotek")

    @item.units = ""
    assert(!@item.save, "Pokus o ulozeni prazdneho retezce jednotek")

    @item.units = "123456789 123456789 123456789 "
    assert(!@item.save, "Pokus o ulozeni dlouheho retezce jednotek (30 znaku)")
  end

  def test_user_validation
    @item = ingrediences(:one)

    @item.user_id = users(:admin).id
    assert(@item.save, "Pokus o ulozeni uzivatele s ID admina")

    @item.user_id = 0
    assert(!@item.save, "Pokus o ulozeni uzivatele s ID 0")

    @item.user_id = nil
    assert(!@item.save, "Pokus o ulozeni NULL uzivatele")
  end
end
