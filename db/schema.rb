# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100103203545) do

  create_table "contents", :force => true do |t|
    t.integer  "page_id"
    t.text     "body"
    t.string   "title"
    t.integer  "charlimit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "text_identifier"
  end

  create_table "conversation_entries", :force => true do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "conversations", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subject"
  end

  create_table "groups", :force => true do |t|
    t.integer  "group_type_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "image_slide_shows", :force => true do |t|
    t.string   "title"
    t.string   "text_identifier"
    t.integer  "page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "image_slide_show_id"
    t.string   "title"
    t.integer  "position"
    t.integer  "page_id"
    t.string   "text_identifier"
    t.text     "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "path"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotes", :force => true do |t|
    t.text     "body"
    t.string   "author"
    t.integer  "page_id"
    t.string   "text_identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "testimonials", :force => true do |t|
    t.text     "body"
    t.string   "name"
    t.string   "location"
    t.integer  "user_id"
    t.boolean  "published",  :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "user_conversations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.boolean  "creator",         :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_groups", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.boolean  "moderator",  :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                  :null => false
    t.string   "crypted_password",                       :null => false
    t.string   "password_salt",                          :null => false
    t.string   "persistence_token",                      :null => false
    t.string   "single_access_token",                    :null => false
    t.string   "perishable_token",                       :null => false
    t.integer  "login_count",         :default => 0,     :null => false
    t.integer  "failed_login_count",  :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.boolean  "admin",               :default => false, :null => false
    t.boolean  "super_user",          :default => false, :null => false
    t.string   "name"
    t.boolean  "registered",          :default => true,  :null => false
    t.boolean  "active",              :default => false, :null => false
    t.boolean  "banned",              :default => false, :null => false
  end

end
