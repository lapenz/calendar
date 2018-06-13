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

ActiveRecord::Schema.define(version: 20180613130501) do

  create_table "appointments", force: :cascade do |t|
    t.integer  "provider_id",          limit: 3
    t.integer  "companies_service_id", limit: 3
    t.integer  "client_id",            limit: 3
    t.string   "title",                limit: 45
    t.datetime "start"
    t.datetime "end"
    t.integer  "all_day",              limit: 1
    t.string   "obs",                  limit: 200
    t.decimal  "price",                            precision: 10, scale: 2
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
  end

  add_index "appointments", ["client_id"], name: "index_appointments_on_client_id", using: :btree
  add_index "appointments", ["companies_service_id"], name: "index_appointments_on_companies_service_id", using: :btree
  add_index "appointments", ["provider_id", "start"], name: "index_appointments_on_provider_id_and_start", unique: true, using: :btree
  add_index "appointments", ["provider_id"], name: "index_appointments_on_provider_id", using: :btree

  create_table "clients", force: :cascade do |t|
    t.string   "name",       limit: 150
    t.string   "email",      limit: 200
    t.string   "phone",      limit: 40
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "company_id", limit: 4
  end

  add_index "clients", ["email", "company_id"], name: "index_clients_on_email_and_company_id", unique: true, using: :btree

  create_table "companies", force: :cascade do |t|
    t.integer  "user_id",           limit: 3
    t.integer  "plan_id",           limit: 3
    t.string   "name",              limit: 150
    t.string   "email",             limit: 150
    t.string   "phone",             limit: 40
    t.string   "street",            limit: 200
    t.string   "city",              limit: 200
    t.string   "slogan",            limit: 100
    t.string   "logo",              limit: 2083
    t.string   "website",           limit: 2083
    t.string   "minipage_url",      limit: 2083
    t.integer  "schedule_interval", limit: 2,    default: 900
    t.integer  "min_antecedence",   limit: 3,    default: 3600
    t.integer  "max_antecedence",   limit: 4,    default: 2592000
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "companies", ["plan_id"], name: "index_companies_on_plan_id", using: :btree
  add_index "companies", ["user_id"], name: "index_companies_on_user_id", using: :btree

  create_table "companies_services", force: :cascade do |t|
    t.integer  "company_id",  limit: 3
    t.integer  "service_id",  limit: 3
    t.integer  "duration",    limit: 4,                            null: false
    t.string   "description", limit: 150
    t.decimal  "price",                   precision: 10, scale: 2
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "companies_services", ["company_id"], name: "index_companies_services_on_company_id", using: :btree
  add_index "companies_services", ["service_id"], name: "index_companies_services_on_service_id", using: :btree

  create_table "companies_services_providers", force: :cascade do |t|
    t.integer  "provider_id",          limit: 3
    t.integer  "companies_service_id", limit: 3
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "companies_services_providers", ["companies_service_id"], name: "index_companies_services_providers_on_companies_service_id", using: :btree
  add_index "companies_services_providers", ["provider_id"], name: "index_companies_services_providers_on_provider_id", using: :btree

  create_table "opening_hours", force: :cascade do |t|
    t.integer  "company_id",  limit: 3
    t.integer  "provider_id", limit: 3
    t.string   "weekdays",    limit: 50
    t.time     "from"
    t.time     "to"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "opening_hours", ["company_id"], name: "index_opening_hours_on_company_id", using: :btree
  add_index "opening_hours", ["provider_id"], name: "index_opening_hours_on_provider_id", using: :btree

  create_table "plans", force: :cascade do |t|
    t.string   "name",       limit: 45
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "providers", force: :cascade do |t|
    t.integer  "company_id", limit: 3
    t.string   "name",       limit: 150
    t.string   "email",      limit: 200
    t.string   "phone",      limit: 40
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "providers", ["company_id"], name: "index_providers_on_company_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.string   "name",       limit: 100
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
