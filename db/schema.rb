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

ActiveRecord::Schema.define(version: 2023_05_29_104704) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answer_likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "answer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["answer_id"], name: "index_answer_likes_on_answer_id"
    t.index ["user_id"], name: "index_answer_likes_on_user_id"
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.bigint "user_id", null: false
    t.string "photograph"
    t.string "answer", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "closets", force: :cascade do |t|
    t.bigint "user_id", null: false
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

  create_table "questions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "photograph", null: false
    t.string "question", limit: 100, null: false
    t.string "category", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "social_likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "social_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["social_id"], name: "index_social_likes_on_social_id"
    t.index ["user_id"], name: "index_social_likes_on_user_id"
  end

  create_table "socials", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "tag"
    t.string "message"
    t.string "photograph", null: false
    t.integer "item1"
    t.integer "item2"
    t.integer "item3"
    t.integer "item4"
    t.integer "item5"
    t.integer "item6"
    t.string "search"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_socials_on_user_id"
  end

  create_table "suggests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "style1", null: false
    t.string "style2", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_suggests_on_user_id"
  end

  create_table "user_contacts", force: :cascade do |t|
    t.string "email", null: false
    t.string "name", null: false
    t.string "content", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_relations", force: :cascade do |t|
    t.integer "follow_id", null: false
    t.integer "follower_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "gender", default: ""
    t.string "profile", default: ""
    t.integer "height"
    t.integer "weight"
    t.string "user_name", default: "", null: false
    t.integer "age"
    t.string "avatar"
    t.string "tendency"
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

  add_foreign_key "answer_likes", "answers"
  add_foreign_key "answer_likes", "users"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "closets", "users"
  add_foreign_key "questions", "users"
  add_foreign_key "social_likes", "socials"
  add_foreign_key "social_likes", "users"
  add_foreign_key "socials", "users"
  add_foreign_key "suggests", "users"
end
