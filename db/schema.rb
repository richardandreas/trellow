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

ActiveRecord::Schema.define(version: 2021_01_18_214619) do

  create_table "email_verifications", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "uuid", limit: 64, null: false
    t.string "new_email", limit: 90
    t.datetime "created_at"
    t.index ["user_id"], name: "index_email_verifications_on_user_id"
    t.index ["uuid"], name: "index_email_verifications_on_uuid"
  end

  create_table "projects", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", limit: 45, null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "name"], name: "index_projects_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "sprints", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.date "start_date"
    t.date "due_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_sprints_on_project_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "username", limit: 45, null: false
    t.string "email", limit: 90, null: false
    t.string "password_digest", null: false
    t.datetime "email_verified_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "email_verifications", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "sprints", "projects"
end
