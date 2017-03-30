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

ActiveRecord::Schema.define(version: 20170330195812) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.datetime "from",       default: -> { "now()" }
    t.integer  "frequency",  default: 0
    t.boolean  "completed",  default: false
    t.integer  "user_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["user_id"], name: "index_events_on_user_id", using: :btree
  end

  create_table "meds", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_meds_on_user_id", using: :btree
  end

  create_table "mood_lists", force: :cascade do |t|
    t.string   "moods"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_mood_lists_on_user_id", using: :btree
  end

  create_table "moods", force: :cascade do |t|
    t.integer  "mood"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_moods_on_user_id", using: :btree
  end

  create_table "notes", force: :cascade do |t|
    t.string   "title",      default: "Untitled"
    t.text     "text"
    t.string   "tags",       default: ""
    t.integer  "user_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["user_id"], name: "index_notes_on_user_id", using: :btree
  end

  create_table "todos", force: :cascade do |t|
    t.string   "todo"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "featured",   default: false
    t.index ["user_id"], name: "index_todos_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "phone"
    t.string   "phone_provider"
    t.string   "sms_frequency"
  end

  add_foreign_key "events", "users"
  add_foreign_key "meds", "users"
  add_foreign_key "mood_lists", "users"
  add_foreign_key "moods", "users"
  add_foreign_key "notes", "users"
  add_foreign_key "todos", "users"
end
