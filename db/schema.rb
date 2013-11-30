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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131130155613) do

  create_table "archevents", force: true do |t|
    t.datetime "when"
    t.integer  "program_id"
    t.boolean  "is_finished", default: false
  end

  create_table "events", force: true do |t|
    t.string  "name"
    t.text    "description"
    t.string  "genre",           limit: 50
    t.string  "deejays",                                   null: false
    t.integer "day_of_week"
    t.string  "start_hour",      limit: 50
    t.string  "start_minute",    limit: 50
    t.string  "end_hour",        limit: 50
    t.string  "end_minute",      limit: 50
    t.boolean "is_active",                  default: true
    t.string  "email"
    t.string  "amazon_filename", limit: 50
    t.string  "program_url"
  end

  create_table "inquiries", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listener_stats", force: true do |t|
    t.integer  "listeners"
    t.datetime "created_at"
    t.integer  "program_id"
  end

  create_table "local_songs", force: true do |t|
    t.string   "artist_name"
    t.string   "title"
    t.string   "email"
    t.string   "filename"
    t.datetime "created_at"
  end

  create_table "programs", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "genre",               limit: 50
    t.string   "deejays",                                       null: false
    t.integer  "day_of_week"
    t.string   "start_hour",          limit: 50
    t.string   "start_minute",        limit: 50
    t.string   "end_hour",            limit: 50
    t.string   "end_minute",          limit: 50
    t.boolean  "is_active",                      default: true
    t.string   "email"
    t.string   "amazon_filename",     limit: 50
    t.string   "program_url"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "shows", force: true do |t|
    t.datetime "when"
    t.integer  "program_id"
    t.boolean  "is_finished", default: false
  end

  create_table "videofeatures", force: true do |t|
    t.string "url"
    t.string "caption"
  end

end
