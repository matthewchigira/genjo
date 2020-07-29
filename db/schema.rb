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

ActiveRecord::Schema.define(version: 20200213104950) do

  create_table "diaries", force: :cascade do |t|
    t.date "date"
    t.text "title"
    t.text "entry"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_diaries_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_diaries_on_user_id"
  end

  create_table "targets", force: :cascade do |t|
    t.text "name"
    t.text "description"
    t.integer "target_steps"
    t.integer "completed_steps"
    t.string "step_name"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sort_order"
    t.index ["user_id"], name: "index_targets_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.text "name"
    t.text "description"
    t.date "due_date"
    t.boolean "is_high_priority"
    t.boolean "is_complete"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["due_date", "is_complete"], name: "index_tasks_on_due_date_and_is_complete"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "remember_digest"
    t.string "activation_digest"
    t.string "reset_digest"
    t.boolean "activated", default: false
    t.boolean "admin", default: false
    t.boolean "private", default: false
    t.datetime "reset_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "deletion_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
