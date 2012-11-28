# coding:utf-8

APP_NAME = "Kuchařka"

#narocnosti
LEVEL_TEXT = Array.new
LEVEL_TEXT[0] = "obtížnost nespecifikovaná";
LEVEL_TEXT[1] = "velmi jednoduchý";
LEVEL_TEXT[2] = "jednoduchý";
LEVEL_TEXT[3] = "středně složitý";
LEVEL_TEXT[4] = "složitý";
LEVEL_TEXT[5] = "velmi složitý";

#typy komentaru
COMMENT_TYPE = Hash.new
COMMENT_TYPE['users'] = 0;
COMMENT_TYPE['recipes'] = 1;
COMMENT_TYPE['ingrediences'] = 2;
COMMENT_TYPE['articles'] = 3;

COMMENT_TYPE_TEXT = Array.new
COMMENT_TYPE_TEXT[COMMENT_TYPE['users']] = "uživatel"
COMMENT_TYPE_TEXT[COMMENT_TYPE['recipes']] = "recept"
COMMENT_TYPE_TEXT[COMMENT_TYPE['ingrediences']] = "ingredience"
COMMENT_TYPE_TEXT[COMMENT_TYPE['articles']] = "článek"