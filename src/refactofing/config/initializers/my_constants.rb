# coding:utf-8

APP_NAME = "Kuchařka"

#narocnosti
LEVEL_TEXT = Array.new
LEVEL_TEXT[0] = "obtížnost nespecifikovaná";
LEVEL_TEXT[1] = "Nejjednodušší";
LEVEL_TEXT[2] = "Jednoduchý";
LEVEL_TEXT[3] = "Střední";
LEVEL_TEXT[4] = "Pokročilý";
LEVEL_TEXT[5] = "Killer";
LEVEL_CLASS = Array.new
LEVEL_CLASS[0] = "";
LEVEL_CLASS[1] = "default";
LEVEL_CLASS[2] = "badge-success";
LEVEL_CLASS[3] = "badge-warning";
LEVEL_CLASS[4] = "badge-important";
LEVEL_CLASS[5] = "badge-inverse";

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

# lednicka
MIN_KOEF_FOR_FRIDGE_RESULT = 0.5