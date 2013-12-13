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

ActiveRecord::Schema.define(version: 20131213233308) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "awards", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "awards_films", force: true do |t|
    t.integer "award_id"
    t.integer "film_id"
  end

  create_table "comments", force: true do |t|
    t.string   "author"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "film_id"
  end

  create_table "festivals", force: true do |t|
    t.string   "name"
    t.string   "festival_url"
    t.string   "background_colour"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.datetime "start"
    t.datetime "end"
    t.string   "status"
    t.boolean  "show_date"
  end

  create_table "films", force: true do |t|
    t.string   "name"
    t.text     "embed_url"
    t.integer  "up_votes",           default: 0
    t.integer  "down_votes",         default: 0
    t.integer  "festival_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "slug"
    t.string   "director"
    t.string   "writer"
    t.string   "starring"
    t.text     "description"
    t.integer  "run_time"
    t.string   "screening"
    t.datetime "start"
    t.datetime "end"
  end

  create_table "films_genres", force: true do |t|
    t.integer "film_id"
    t.integer "genre_id"
  end

  create_table "films_locations", force: true do |t|
    t.integer "film_id"
    t.integer "location_id"
  end

  create_table "genres", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "key_inputs", force: true do |t|
    t.text     "about_blurb"
    t.text     "about_full"
    t.text     "terms_and_conditions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "up_vote_message"
    t.string   "down_vote_message"
    t.string   "blocked_image_file_name"
    t.string   "blocked_image_content_type"
    t.integer  "blocked_image_file_size"
    t.datetime "blocked_image_updated_at"
    t.string   "unavailable_image_file_name"
    t.string   "unavailable_image_content_type"
    t.integer  "unavailable_image_file_size"
    t.datetime "unavailable_image_updated_at"
  end

  create_table "locations", force: true do |t|
    t.string   "address"
    t.string   "location_type"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "city"
    t.string   "state_or_province"
    t.string   "country"
  end

  create_table "simple_captcha_data", force: true do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], name: "idx_key", using: :btree

  create_table "votes", force: true do |t|
    t.string   "ip_address"
    t.integer  "film_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
