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

ActiveRecord::Schema.define(version: 20160415143028) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "line_1"
    t.string   "line_2"
    t.string   "locality"
    t.string   "province"
    t.string   "postcode"
    t.string   "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "client_id"
  end

  add_index "addresses", ["client_id"], name: "index_addresses_on_client_id", using: :btree

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.integer  "number"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "user_id"
    t.string   "currency",   default: "EUR"
    t.integer  "rate_cents", default: 0,     null: false
  end

  add_index "clients", ["user_id"], name: "index_clients_on_user_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "web"
    t.string   "email"
    t.string   "phone"
    t.string   "tax_id"
    t.decimal  "vat_rate"
    t.integer  "address_id"
    t.integer  "payment_address_id"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "companies", ["address_id"], name: "index_companies_on_address_id", using: :btree
  add_index "companies", ["payment_address_id"], name: "index_companies_on_payment_address_id", using: :btree
  add_index "companies", ["user_id"], name: "index_companies_on_user_id", using: :btree

  create_table "payment_addresses", force: :cascade do |t|
    t.string   "type"
    t.string   "account_holder"
    t.string   "iban"
    t.string   "bic"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "client_id"
  end

  add_index "projects", ["client_id"], name: "index_projects_on_client_id", using: :btree
  add_index "projects", ["parent_id"], name: "index_projects_on_parent_id", using: :btree
  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "time_entries", force: :cascade do |t|
    t.integer  "project_id"
    t.boolean  "manual",     default: false
    t.datetime "started_at"
    t.datetime "stopped_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "user_id"
  end

  add_index "time_entries", ["project_id"], name: "index_time_entries_on_project_id", using: :btree
  add_index "time_entries", ["user_id"], name: "index_time_entries_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.text     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  add_foreign_key "addresses", "clients"
  add_foreign_key "clients", "users"
  add_foreign_key "companies", "addresses"
  add_foreign_key "companies", "payment_addresses"
  add_foreign_key "companies", "users"
  add_foreign_key "projects", "clients"
  add_foreign_key "projects", "users"
  add_foreign_key "time_entries", "projects"
  add_foreign_key "time_entries", "users"
end
