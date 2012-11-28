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

ActiveRecord::Schema.define(:version => 20121121183220) do

  create_table "articles", :force => true do |t|
    t.string   "title",      :null => false
    t.text     "annotation", :null => false
    t.text     "content",    :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "articles", ["user_id"], :name => "index_articles_on_user_id"

  create_table "recipes", :force => true do |t|
    t.string   "name",       :null => false
    t.text     "annotation", :null => false
    t.text     "content",    :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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
  add_index "users", ["email"], :name => "email", :unique => true
  add_index "users", ["username"], :name => "username", :unique => true

end
