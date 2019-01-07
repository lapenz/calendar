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

ActiveRecord::Schema.define(version: 2018_12_26_125835) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", id: :serial, force: :cascade do |t|
    t.integer "resource_id"
    t.integer "companies_service_id"
    t.integer "client_id"
    t.integer "company_id"
    t.datetime "start"
    t.datetime "end"
    t.string "obs", limit: 200
    t.decimal "price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "allday"
    t.integer "repeat_id"
    t.boolean "active", default: true
    t.integer "remindertime"
    t.index ["client_id"], name: "index_appointments_on_client_id"
    t.index ["companies_service_id"], name: "index_appointments_on_companies_service_id"
    t.index ["company_id"], name: "index_appointments_on_company_id"
    t.index ["resource_id"], name: "index_appointments_on_resource_id"
  end

  create_table "clients", id: :serial, force: :cascade do |t|
    t.string "name", limit: 150
    t.string "email", limit: 200
    t.string "phone", limit: 40
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id"
    t.index ["email", "company_id"], name: "index_clients_on_email_and_company_id", unique: true
  end

  create_table "companies", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "plan_id"
    t.string "name", limit: 150
    t.string "email", limit: 150
    t.string "phone", limit: 40
    t.string "street", limit: 200
    t.string "city", limit: 200
    t.string "slogan", limit: 100
    t.string "logo", limit: 2083
    t.string "website", limit: 2083
    t.string "minipage_url", limit: 2083
    t.integer "schedule_interval", limit: 2, default: 900
    t.integer "min_antecedence", default: 3600
    t.integer "max_antecedence", default: 2592000
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_companies_on_plan_id"
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "companies_services", id: :serial, force: :cascade do |t|
    t.integer "company_id"
    t.integer "service_id"
    t.integer "duration", null: false
    t.string "description", limit: 150
    t.decimal "price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "visible", default: true
    t.index ["company_id"], name: "index_companies_services_on_company_id"
    t.index ["service_id"], name: "index_companies_services_on_service_id"
  end

  create_table "companies_services_resources", id: :serial, force: :cascade do |t|
    t.integer "resource_id"
    t.integer "companies_service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["companies_service_id"], name: "index_companies_services_resources_on_companies_service_id"
    t.index ["resource_id"], name: "index_companies_services_resources_on_resource_id"
  end

  create_table "opening_hours", id: :serial, force: :cascade do |t|
    t.integer "company_id"
    t.integer "resource_id"
    t.string "weekdays", limit: 50
    t.time "from"
    t.time "to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_opening_hours_on_company_id"
    t.index ["resource_id"], name: "index_opening_hours_on_resource_id"
  end

  create_table "plans", id: :serial, force: :cascade do |t|
    t.string "name", limit: 45
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "repeats", force: :cascade do |t|
    t.string "typerepeat", limit: 45
    t.integer "interval", limit: 2
    t.string "weekdays", limit: 50
    t.date "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resources", id: :serial, force: :cascade do |t|
    t.integer "company_id"
    t.string "name", limit: 150
    t.string "email", limit: 200
    t.string "phone", limit: 40
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_resources_on_company_id"
  end

  create_table "services", id: :serial, force: :cascade do |t|
    t.string "name", limit: 100
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
