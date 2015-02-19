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

ActiveRecord::Schema.define(version: 20150219020933) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dogs", force: true do |t|
    t.string   "dog_name"
    t.string   "breed"
    t.date     "birthday"
    t.boolean  "food_low_flag"
    t.boolean  "treats_low_flag"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "owners", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "username"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "is_site_admin"
  end

  create_table "relationships", force: true do |t|
    t.integer  "dog_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_dog_admin"
  end

  add_index "relationships", ["dog_id"], name: "index_relationships_on_dog_id", using: :btree
  add_index "relationships", ["owner_id"], name: "index_relationships_on_owner_id", using: :btree

end
