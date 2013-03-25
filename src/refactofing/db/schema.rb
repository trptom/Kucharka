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

ActiveRecord::Schema.define(:version => 20130102002000) do

  create_table "articles", :force => true do |t|
    t.string   "title",      :null => false
    t.text     "annotation", :null => false
    t.text     "content",    :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "articles", ["user_id"], :name => "index_articles_on_user_id"

  create_table "articles_recipes", :id => false, :force => true do |t|
    t.integer "article_id"
    t.integer "recipe_id"
  end

  add_index "articles_recipes", ["article_id", "recipe_id"], :name => "index_articles_recipes_on_article_id_and_recipe_id"
  add_index "articles_recipes", ["recipe_id", "article_id"], :name => "index_articles_recipes_on_recipe_id_and_article_id"

  create_table "comments", :force => true do |t|
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
    t.string   "name",                         :null => false
    t.text     "description",                  :null => false
    t.integer  "category_type", :default => 0, :null => false
    t.integer  "user_id",                      :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "ingredience_categories_ingrediences", :id => false, :force => true do |t|
    t.integer "ingredience_category_id"
    t.integer "ingredience_id"
  end

  create_table "ingredience_recipe_connectors", :force => true do |t|
    t.integer  "ingredience_id"
    t.integer  "recipe_id"
    t.float    "quantity",       :default => 1.0, :null => false
    t.integer  "importance",     :default => 1,   :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "ingrediences", :force => true do |t|
    t.string   "name",                            :null => false
    t.text     "annotation",                      :null => false
    t.text     "content",                         :null => false
    t.integer  "avaliability",     :default => 1, :null => false
    t.string   "units",                           :null => false
    t.integer  "user_id",                         :null => false
    t.integer  "activation_state", :default => 0, :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ingrediences", ["user_id"], :name => "index_ingrediences_on_user_id"

  create_table "marks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "recipe_id"
    t.integer  "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "marks", ["recipe_id"], :name => "index_marks_on_recipe_id"
  add_index "marks", ["user_id"], :name => "index_marks_on_user_id"

  create_table "recipe_categories", :force => true do |t|
    t.string   "name",                         :null => false
    t.text     "description",                  :null => false
    t.integer  "category_type", :default => 0, :null => false
    t.integer  "user_id",                      :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "recipe_categories_recipes", :id => false, :force => true do |t|
    t.integer "recipe_category_id"
    t.integer "recipe_id"
  end

  create_table "recipe_recipe_connectors", :force => true do |t|
    t.integer  "recipe_id",    :null => false
    t.integer  "subrecipe_id", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "recipe_recipe_connectors", ["recipe_id"], :name => "index_recipe_recipe_connectors_on_recipe_id"
  add_index "recipe_recipe_connectors", ["subrecipe_id"], :name => "index_recipe_recipe_connectors_on_subrecipe_id"

  create_table "recipes", :force => true do |t|
    t.string   "name",                           :null => false
    t.text     "annotation",                     :null => false
    t.text     "content",                        :null => false
    t.integer  "level",          :default => 0,  :null => false
    t.integer  "estimated_time", :default => 60, :null => false
    t.integer  "user_id",                        :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "image"
  end

  add_index "recipes", ["user_id"], :name => "index_recipes_on_user_id"

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

end
