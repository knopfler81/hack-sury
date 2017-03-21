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

ActiveRecord::Schema.define(version: 20170308133939) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachinary_files", force: :cascade do |t|
    t.string   "attachinariable_type"
    t.integer  "attachinariable_id"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree
  end

  create_table "bookings", force: :cascade do |t|
    t.integer  "booking_guests"
    t.boolean  "payment_status",      default: false
    t.integer  "user_id"
    t.integer  "trip_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.text     "motivation_message"
    t.integer  "booking_price_cents", default: 0,     null: false
    t.json     "payment"
    t.index ["trip_id"], name: "index_bookings_on_trip_id", using: :btree
    t.index ["user_id"], name: "index_bookings_on_user_id", using: :btree
  end

  create_table "destinations", force: :cascade do |t|
    t.string   "location"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.boolean  "read",       default: false
    t.string   "content"
    t.integer  "user_id"
    t.string   "topic_type"
    t.integer  "topic_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["topic_type", "topic_id"], name: "index_notifications_on_topic_type_and_topic_id", using: :btree
    t.index ["user_id"], name: "index_notifications_on_user_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "description"
    t.integer  "rating"
    t.string   "best_picture"
    t.integer  "trip_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["trip_id"], name: "index_reviews_on_trip_id", using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "steps", force: :cascade do |t|
    t.integer  "trip_id"
    t.integer  "destination_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "step_location"
    t.index ["destination_id"], name: "index_steps_on_destination_id", using: :btree
    t.index ["trip_id"], name: "index_steps_on_trip_id", using: :btree
  end

  create_table "trips", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "pictures"
    t.string   "start_city"
    t.float    "start_long"
    t.float    "start_lat"
    t.string   "arrival_city"
    t.float    "arrival_long"
    t.float    "arrival_lat"
    t.date     "start_date"
    t.date     "arrival_date"
    t.boolean  "flexible",                default: true
    t.boolean  "confirmed",               default: false
    t.integer  "total_estimated_price"
    t.integer  "capacity"
    t.integer  "min_passengers_required"
    t.integer  "user_id"
    t.boolean  "active",                  default: true
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.boolean  "has_car"
    t.integer  "transportation_costs"
    t.integer  "rental_costs"
    t.index ["user_id"], name: "index_trips_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nickname"
    t.boolean  "driving_licence"
    t.string   "avatar"
    t.text     "bio"
    t.boolean  "admin",                  default: false, null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "token_expiry"
    t.date     "birth_date"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "bookings", "trips"
  add_foreign_key "bookings", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "reviews", "trips"
  add_foreign_key "reviews", "users"
  add_foreign_key "steps", "destinations"
  add_foreign_key "steps", "trips"
  add_foreign_key "trips", "users"
end
