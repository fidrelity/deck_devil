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

ActiveRecord::Schema.define(version: 20150226142558) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.integer  "deck_id"
    t.string   "name"
    t.json     "data"
    t.integer  "times"
    t.integer  "multiverse_id"
    t.text     "colors"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "decks", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "condition_from"
    t.string   "condition_to"
    t.float    "price"
    t.json     "data"
    t.text     "cards_list"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "shipping_options", force: :cascade do |t|
    t.integer  "deck_id"
    t.string   "region_code"
    t.float    "value"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "shipping_options", ["deck_id"], name: "index_shipping_options_on_deck_id", using: :btree

end
