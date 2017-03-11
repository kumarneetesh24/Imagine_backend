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

ActiveRecord::Schema.define(version: 20170313055824) do

  create_table "languages", force: :cascade do |t|
    t.string   "lang_code",     null: false
    t.string   "equal"
    t.string   "greater"
    t.string   "smaller"
    t.string   "double_equals"
    t.string   "and"
    t.string   "or"
    t.string   "int"
    t.string   "string"
    t.string   "print"
    t.string   "read"
    t.string   "function"
    t.string   "return"
    t.string   "if_else"
    t.string   "for"
    t.string   "while"
    t.string   "do_while"
    t.string   "switch"
    t.string   "continue"
    t.string   "break"
    t.string   "start_bkt"
    t.string   "end_bkt"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "problems", force: :cascade do |t|
    t.string   "pname"
    t.string   "pcode"
    t.string   "statement"
    t.boolean  "state"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "submissions_count"
  end

  create_table "submissions", force: :cascade do |t|
    t.string   "status_code",      default: "PE"
    t.integer  "problem_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "user_source_code"
    t.string   "error_desc"
    t.index ["problem_id"], name: "index_submissions_on_problem_id"
  end

  create_table "test_cases", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "testcase_file_name"
    t.string   "testcase_content_type"
    t.integer  "testcase_file_size"
    t.datetime "testcase_updated_at"
    t.string   "testcase_output_file_name"
    t.string   "testcase_output_content_type"
    t.integer  "testcase_output_file_size"
    t.datetime "testcase_output_updated_at"
    t.integer  "problem_id"
    t.index ["problem_id"], name: "index_test_cases_on_problem_id"
  end

end
