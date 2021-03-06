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

ActiveRecord::Schema.define(version: 20140603193129) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "archevents", force: true do |t|
    t.datetime "when"
    t.integer  "program_id"
    t.boolean  "is_finished"
  end

  create_table "dj_applications", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.text     "show_description"
    t.string   "show_name"
    t.string   "dj_name"
    t.boolean  "is_cost_ok"
    t.text     "availability"
    t.text     "internal_contacts"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "episodes", force: true do |t|
    t.datetime "recorded_at"
    t.integer  "program_id"
    t.integer  "record_time"
    t.string   "title"
    t.string   "recording_file_name"
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
    t.string   "artist_name", limit: 510
    t.string   "title",       limit: 510
    t.string   "email",       limit: 510
    t.string   "filename",    limit: 510
    t.datetime "created_at"
  end

  create_table "programs", force: true do |t|
    t.string   "title",               limit: 510
    t.text     "description"
    t.string   "genre",               limit: 100
    t.integer  "day_of_week"
    t.string   "start_hour",          limit: 100
    t.string   "start_minute",        limit: 100
    t.string   "end_hour",            limit: 100
    t.string   "end_minute",          limit: 100
    t.boolean  "is_active"
    t.string   "email",               limit: 510
    t.string   "amazon_filename",     limit: 100
    t.string   "program_url",         limit: 510
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "user_id"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "schedules", force: true do |t|
    t.integer "program_id"
    t.time    "start_time"
    t.integer "duration"
    t.integer "day_of_week"
  end

  create_table "tracks", force: true do |t|
    t.string   "content"
    t.integer  "episode_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "phone"
    t.string   "djname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "videofeatures", force: true do |t|
    t.string "url",     limit: 510
    t.string "caption", limit: 510
  end

end
