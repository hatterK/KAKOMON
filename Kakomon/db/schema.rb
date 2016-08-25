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

ActiveRecord::Schema.define(version: 20160820222252) do

  create_table "exam_dates", force: :cascade do |t|
    t.integer  "year",       null: false
    t.string   "term",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.string   "name",             null: false
    t.string   "hashed_password",  null: false
    t.integer  "access_authority", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "past_questions", force: :cascade do |t|
    t.string   "subject",      null: false
    t.string   "kana"
    t.string   "teacher"
    t.integer  "views",        null: false
    t.string   "image",        null: false
    t.integer  "exam_date_id", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "past_questions", ["exam_date_id"], name: "index_past_questions_on_exam_date_id"

  create_table "tag_relations", force: :cascade do |t|
    t.integer  "past_question_id", null: false
    t.integer  "tag_id",           null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "tag_relations", ["past_question_id"], name: "index_tag_relations_on_past_question_id"
  add_index "tag_relations", ["tag_id"], name: "index_tag_relations_on_tag_id"

  create_table "tags", force: :cascade do |t|
    t.string   "name",       null: false
    t.boolean  "lock",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
