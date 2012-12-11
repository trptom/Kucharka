# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121211195049) do

  create_table "articles", :force => true do |t|
    t.string   "title",      :null => false
    t.text     "annotation", :null => false
    t.text     "content",    :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "articles", ["user_id"], :name => "index_articles_on_user_id"

  create_table "comments", :force => true do |t|
    t.string   "title",          :null => false
    t.text     "content",        :null => false
    t.integer  "user_id",        :null => false
    t.integer  "comment_type",   :null => false
    t.integer  "recipe_id"
    t.integer  "ingredience_id"
    t.integer  "article_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "comments", ["article_id"], :name => "index_comments_on_article_id"
  add_index "comments", ["ingredience_id"], :name => "index_comments_on_ingredience_id"
  add_index "comments", ["recipe_id"], :name => "index_comments_on_recipe_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "ingredience_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ingredience_category_links", :force => true do |t|
    t.integer  "ingredience_id"
    t.integer  "ingredienceCategory_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "ingredience_category_links", ["ingredienceCategory_id"], :name => "index_ingredience_category_links_on_ingredienceCategory_id"
  add_index "ingredience_category_links", ["ingredience_id"], :name => "index_ingredience_category_links_on_ingredience_id"

  create_table "ingrediences", :force => true do |t|
    t.string   "name",                        :null => false
    t.text     "annotation",                  :null => false
    t.text     "content",                     :null => false
    t.integer  "avaliability", :default => 1, :null => false
    t.integer  "user_id",                     :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "ingrediences", ["user_id"], :name => "index_ingrediences_on_user_id"

  create_table "recipe_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "recipe_category_links", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "recipeCategory_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "recipe_category_links", ["recipeCategory_id"], :name => "index_recipe_category_links_on_recipeCategory_id"
  add_index "recipe_category_links", ["recipe_id"], :name => "index_recipe_category_links_on_recipe_id"

  create_table "recipes", :force => true do |t|
    t.string   "name",                           :null => false
    t.text     "annotation",                     :null => false
    t.text     "content",                        :null => false
    t.integer  "level",          :default => 0,  :null => false
    t.integer  "estimated_time", :default => 60, :null => false
    t.integer  "user_id",                        :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "recipes", ["user_id"], :name => "index_recipes_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "title",       :null => false
    t.text     "description", :null => false
    t.text     "the_role",    :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",                                      :null => false
    t.string   "email",                                         :null => false
    t.string   "crypted_password",                              :null => false
    t.string   "salt"
    t.integer  "self_ruleset",                :default => 0,    :null => false
    t.integer  "others_ruleset",              :default => 0,    :null => false
    t.string   "first_name"
    t.string   "second_name"
    t.string   "age"
    t.text     "note"
    t.boolean  "active",                      :default => true, :null => false
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
  end

  add_index "users", ["activation_token"], :name => "index_users_on_activation_token"
  add_index "users", ["email"], :name => "email", :unique => true
  add_index "users", ["username"], :name => "username", :unique => true

end
