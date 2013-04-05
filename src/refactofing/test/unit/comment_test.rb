# coding:utf-8

require 'test_helper'
require 'comment'

class CommentTest < ActiveSupport::TestCase
  
  def test_create
    # vychazi z ni ostatni testy, tak abych vedel, ze to pada i bez uprav
    @newItem = Comment.new(
      :content => "comment content",
      :comment_type => COMMENT_TYPE['articles'],
      :user_id => users(:admin).id)
    assert(@newItem.save, "Pokus o ulozeni noveho komentare")
  end

  def test_content_validation
    @item = comments(:one)

    @item.content = nil
    assert(!@item.save, "Pokus o ulozeni null obsahu")

    @item.content = ""
    assert(!@item.save, "Pokus o ulozeni prazdneho obsahu")

    content = ""
    for x in 0..100
      content += "extra long extra long extra long extra long extra long ";
    end
    @item.content =  content
    assert(@item.save, "Pokus o ulozeni hodne dlouheho obsahu (melo by projit)")
  end

  def test_user_validation
    @item = comments(:one)

    @item.user_id = users(:admin).id
    assert(@item.save, "Pokus o ulozeni uzivatele s ID admina")

    @item.user_id = 0
    assert(!@item.save, "Pokus o ulozeni uzivatele s ID 0")

    @item.user_id = nil
    assert(!@item.save, "Pokus o ulozeni NULL uzivatele")
  end
end
