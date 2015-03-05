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

ActiveRecord::Schema.define(version: 20150305002114) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bought_cards", force: :cascade do |t|
    t.integer  "card_id"
    t.decimal  "usd_price"
    t.integer  "user_id"
    t.string   "condition"
    t.integer  "quantity"
    t.integer  "bought_list_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "edition"
    t.string   "language"
  end

  add_index "bought_cards", ["bought_list_id"], name: "index_bought_cards_on_bought_list_id", using: :btree
  add_index "bought_cards", ["card_id"], name: "index_bought_cards_on_card_id", using: :btree
  add_index "bought_cards", ["user_id"], name: "index_bought_cards_on_user_id", using: :btree

  create_table "bought_lists", force: :cascade do |t|
    t.decimal  "total_usd"
    t.text     "raw_order"
    t.integer  "buy_list_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "bought_lists", ["buy_list_id"], name: "index_bought_lists_on_buy_list_id", using: :btree
  add_index "bought_lists", ["user_id"], name: "index_bought_lists_on_user_id", using: :btree

  create_table "buy_lists", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "requested"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "order_date"
    t.float    "dolar"
  end

  create_table "cards", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.string   "link"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "condition"
    t.integer  "buy_list_id"
    t.integer  "quantity"
    t.integer  "stock"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "bought_cards", "bought_lists"
  add_foreign_key "bought_cards", "cards"
  add_foreign_key "bought_cards", "users"
  add_foreign_key "bought_lists", "buy_lists"
  add_foreign_key "bought_lists", "users"
end
