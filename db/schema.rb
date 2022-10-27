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

ActiveRecord::Schema[7.0].define(version: 2022_10_27_141046) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "app_users", force: :cascade do |t|
    t.string "cellphone"
    t.string "password_digest"
    t.string "email"
    t.string "firstname"
    t.string "lastname"
    t.date "dob"
  end

  create_table "blacklists", force: :cascade do |t|
    t.string "usercellphone"
    t.bigint "provider_id", null: false
    t.index ["provider_id"], name: "index_blacklists_on_provider_id"
  end

  create_table "clients", force: :cascade do |t|
    t.bigint "app_user_id"
    t.float "lat"
    t.float "lng"
    t.index ["app_user_id"], name: "index_clients_on_app_user_id", unique: true
  end

  create_table "establishments", force: :cascade do |t|
    t.string "name"
    t.bigint "provider_id", null: false
    t.float "lat"
    t.float "lng"
    t.index ["provider_id"], name: "index_establishments_on_provider_id"
  end

  create_table "manual_slot_blueprints", force: :cascade do |t|
    t.time "opentime"
    t.time "closetime"
    t.bigint "slot_blueprint_id", null: false
    t.time "maxduration"
    t.index ["slot_blueprint_id"], name: "index_manual_slot_blueprints_on_slot_blueprint_id"
  end

  create_table "periodic_slot_blueprints", force: :cascade do |t|
    t.time "fromtime"
    t.time "totime"
    t.bigint "slot_blueprint_id", null: false
    t.index ["slot_blueprint_id"], name: "index_periodic_slot_blueprints_on_slot_blueprint_id"
  end

  create_table "providers", force: :cascade do |t|
    t.bigint "app_user_id"
    t.boolean "isverified"
    t.integer "maxstrikes"
    t.string "companyname"
    t.index ["app_user_id"], name: "index_providers_on_app_user_id", unique: true
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "rating"
    t.text "comment"
    t.bigint "establishment_id", null: false
    t.bigint "client_id", null: false
    t.index ["client_id"], name: "index_ratings_on_client_id"
    t.index ["establishment_id"], name: "index_ratings_on_establishment_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "slot_id"
    t.index ["client_id"], name: "index_reservations_on_client_id", unique: true
    t.index ["slot_id"], name: "index_reservations_on_slot_id", unique: true
  end

  create_table "slot_blueprints", force: :cascade do |t|
    t.integer "weekdays"
    t.integer "reservationlimit"
    t.date "fromdate"
    t.date "todate"
    t.bigint "establishment_id", null: false
    t.index ["establishment_id"], name: "index_slot_blueprints_on_establishment_id"
  end

  create_table "slots", force: :cascade do |t|
    t.string "password_digest"
    t.date "date"
    t.bigint "app_user_id"
    t.index ["app_user_id"], name: "index_slots_on_app_user_id", unique: true
  end

  create_table "strikes", force: :cascade do |t|
    t.string "usercellphone"
    t.integer "count", default: 1
    t.bigint "provider_id", null: false
    t.index ["provider_id"], name: "index_strikes_on_provider_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "blacklists", "providers"
  add_foreign_key "clients", "app_users"
  add_foreign_key "establishments", "providers"
  add_foreign_key "manual_slot_blueprints", "slot_blueprints"
  add_foreign_key "periodic_slot_blueprints", "slot_blueprints"
  add_foreign_key "providers", "app_users"
  add_foreign_key "ratings", "clients"
  add_foreign_key "ratings", "establishments"
  add_foreign_key "reservations", "clients"
  add_foreign_key "reservations", "slots"
  add_foreign_key "slot_blueprints", "establishments"
  add_foreign_key "slots", "app_users"
  add_foreign_key "strikes", "providers"
end
