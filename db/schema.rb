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

ActiveRecord::Schema.define(version: 20141214103851) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applications", force: true do |t|
    t.integer  "category",       default: 0
    t.integer  "status",         default: 0
    t.string   "rec_code"
    t.text     "pers_statement"
    t.text     "rel_coursework"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "applications", ["user_id"], name: "index_applications_on_user_id", using: :btree

  create_table "choices", force: true do |t|
    t.integer  "rank"
    t.text     "statement"
    t.text     "budget"
    t.integer  "organization_id"
    t.integer  "application_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "choices", ["application_id"], name: "index_choices_on_application_id", using: :btree
  add_index "choices", ["organization_id"], name: "index_choices_on_organization_id", using: :btree

  create_table "documents", force: true do |t|
    t.integer  "category",          default: 0
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "documents", ["user_id"], name: "index_documents_on_user_id", using: :btree

  create_table "internships", force: true do |t|
    t.integer  "application_id"
    t.string   "name"
    t.string   "city"
    t.string   "country"
    t.string   "supervisor_name"
    t.string   "supervisor_title"
    t.string   "supervisor_email"
    t.string   "supervisor_phone"
    t.string   "faculty_name"
    t.boolean  "financial_aid"
    t.boolean  "unpaid"
    t.boolean  "minimum_length"
    t.boolean  "fulltime"
    t.boolean  "travel_warning"
    t.boolean  "political"
    t.boolean  "social_service"
    t.string   "category"
    t.string   "related_to"
    t.text     "work_scope"
    t.text     "relevance"
    t.text     "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "internships", ["application_id"], name: "index_internships_on_application_id", using: :btree

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "category",          default: 0
    t.string   "description"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "profiles", force: true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "local_street"
    t.string   "local_city"
    t.string   "local_state"
    t.string   "local_postal"
    t.string   "perm_street"
    t.string   "perm_city"
    t.string   "perm_state"
    t.string   "perm_country"
    t.string   "perm_postal"
    t.string   "majors"
    t.string   "minors"
    t.integer  "class_year"
    t.float    "overall_gpa"
    t.float    "major_gpa"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "recommendations", force: true do |t|
    t.string   "email"
    t.string   "name"
    t.integer  "application_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "letter_file_name"
    t.string   "letter_content_type"
    t.integer  "letter_file_size"
    t.datetime "letter_updated_at"
  end

  add_index "recommendations", ["application_id"], name: "index_recommendations_on_application_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role",                   default: 0
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
