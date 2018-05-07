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

ActiveRecord::Schema.define(version: 20180413212125) do

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "code"
    t.boolean "superadmin", default: false
    t.boolean "email_confirmed", default: false
    t.string "password_digest"
    t.string "remember_digest"
    t.string "confirm_token"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "appointments", force: :cascade do |t|
    t.datetime "time"
    t.string "slot"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "histories", force: :cascade do |t|
    t.integer "suit_id"
    t.integer "user_id"
    t.datetime "checkOutTime"
    t.datetime "expectReturnTime"
    t.datetime "returnTime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["suit_id"], name: "index_histories_on_suit_id"
    t.index ["user_id"], name: "index_histories_on_user_id"
  end

  create_table "renters", force: :cascade do |t|
    t.datetime "checkOutTime", null: false
    t.datetime "expectReturnTime", null: false
    t.datetime "returnTime"
    t.string "status", default: "Available"
    t.integer "user_id"
    t.integer "suit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["suit_id"], name: "index_renters_on_suit_id"
    t.index ["user_id"], name: "index_renters_on_user_id"
  end

  create_table "suits", force: :cascade do |t|
    t.string "appid"
    t.string "gender"
    t.string "article"
    t.string "size"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "uin"
    t.string "phone"
    t.string "email"
    t.boolean "available", default: true
    t.boolean "email_confirmed", default: false
    t.integer "suitCount", default: 0
    t.string "confirm_token"
    t.string "password_digest"
    t.string "remember_digest"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
