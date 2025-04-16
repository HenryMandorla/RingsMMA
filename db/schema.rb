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

ActiveRecord::Schema[8.0].define(version: 2025_04_15_104006) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "gym_class_id", null: false
    t.datetime "attended_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gym_class_id"], name: "index_attendances_on_gym_class_id"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "forum_post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["forum_post_id"], name: "index_comments_on_forum_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "forum_posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_forum_posts_on_user_id"
  end

  create_table "gym_classes", force: :cascade do |t|
    t.string "name"
    t.datetime "schedule"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "max_capacity"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "belt_level"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.decimal "mat_hours", precision: 10, scale: 1, default: "0.0"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weekly_leaderboards", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "mat_hours", precision: 10, scale: 2
    t.integer "rank"
    t.date "week_start_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_weekly_leaderboards_on_user_id"
    t.index ["week_start_date", "rank"], name: "index_weekly_leaderboards_on_week_start_date_and_rank"
  end

  add_foreign_key "attendances", "gym_classes"
  add_foreign_key "attendances", "users"
  add_foreign_key "comments", "forum_posts"
  add_foreign_key "comments", "users"
  add_foreign_key "forum_posts", "users"
  add_foreign_key "weekly_leaderboards", "users"
end
