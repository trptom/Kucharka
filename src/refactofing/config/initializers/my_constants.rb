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

# lednicka
MIN_KOEF_FOR_FRIDGE_RESULT = 0.5

# search
MAX_SEARCH_RESULTS = 100 # maximalni pocet vysledku kledani pro dany typ (clanek / recept)