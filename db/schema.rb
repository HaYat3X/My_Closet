# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_05_16_112311) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "closets", force: :cascade do |t|
    t.integer "user_id"
    t.string "photograph", null: false
    t.string "big_Category", null: false
    t.string "small_Category"
    t.integer "price"
    t.string "color"
    t.string "size"
    t.string "brand"
    t.string "search"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_closets_on_user_id"
  end

  create_table "socials", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "tag"
    t.string "message"
    t.string "photograph", null: false
    t.integer "item1"
    t.integer "item2"
    t.integer "item3"
    t.integer "item4"
    t.integer "item5"
    t.integer "item6"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item1"], name: "index_socials_on_item1"
    t.index ["item2"], name: "index_socials_on_item2"
    t.index ["item3"], name: "index_socials_on_item3"
    t.index ["item4"], name: "index_socials_on_item4"
    t.index ["item5"], name: "index_socials_on_item5"
    t.index ["item6"], name: "index_socials_on_item6"
    t.index ["user_id"], name: "index_socials_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "gender", default: ""
    t.string "profile", default: ""
    t.integer "height"
    t.integer "weight"
    t.string "user_name", default: "", null: false
    t.integer "age"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
