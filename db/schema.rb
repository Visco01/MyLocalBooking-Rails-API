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

ActiveRecord::Schema[7.0].define(version: 2022_12_24_163715) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "app_users", force: :cascade do |t|
    t.string "cellphone", limit: 13, null: false
    t.string "password_digest", null: false
    t.string "email"
    t.string "firstname", null: false
    t.string "lastname", null: false
    t.date "dob", null: false
    t.index ["cellphone"], name: "index_app_users_on_cellphone", unique: true
    t.index ["cellphone"], name: "unique_cellphone", unique: true
  end

  create_table "blacklists", force: :cascade do |t|
    t.string "usercellphone", limit: 13
    t.bigint "provider_id", null: false
    t.index ["provider_id"], name: "index_blacklists_on_provider_id"
    t.index ["usercellphone", "provider_id"], name: "one_per_client_provider_blacklists", unique: true
  end

  create_table "clients", force: :cascade do |t|
    t.bigint "app_user_id", null: false
    t.float "lat"
    t.float "lng"
    t.index ["app_user_id"], name: "index_clients_on_app_user_id", unique: true
    t.check_constraint "lat IS NULL AND lng IS NULL OR lat IS NOT NULL AND lng IS NOT NULL", name: "both_coordinates_provided"
  end

  create_table "establishments", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "provider_id", null: false
    t.float "lat", null: false
    t.float "lng", null: false
    t.text "place_id", null: false
    t.text "address", null: false
    t.index ["address", "name"], name: "unique_address_name", unique: true
    t.index ["provider_id"], name: "index_establishments_on_provider_id"
  end

  create_table "manual_slot_blueprints", force: :cascade do |t|
    t.time "opentime", null: false
    t.time "closetime", null: false
    t.bigint "slot_blueprint_id", null: false
    t.time "maxduration", null: false
    t.index ["slot_blueprint_id"], name: "index_manual_slot_blueprints_on_slot_blueprint_id"
    t.check_constraint "closetime > opentime", name: "time_order"
    t.check_constraint "maxduration::interval <= (closetime - opentime)", name: "valid_duration"
  end

  create_table "manual_slots", force: :cascade do |t|
    t.time "fromtime", null: false
    t.time "totime", null: false
    t.bigint "slot_id", null: false
    t.bigint "manual_slot_blueprint_id", null: false
    t.index ["manual_slot_blueprint_id"], name: "index_manual_slots_on_manual_slot_blueprint_id"
    t.index ["slot_id"], name: "index_manual_slots_on_slot_id"
    t.check_constraint "totime > fromtime", name: "time_order"
  end

  create_table "periodic_slot_blueprints", force: :cascade do |t|
    t.time "fromtime", null: false
    t.time "totime", null: false
    t.bigint "slot_blueprint_id", null: false
    t.index ["slot_blueprint_id"], name: "index_periodic_slot_blueprints_on_slot_blueprint_id"
    t.check_constraint "totime > fromtime", name: "time_order"
  end

  create_table "periodic_slots", force: :cascade do |t|
    t.bigint "slot_id", null: false
    t.bigint "periodic_slot_blueprint_id", null: false
    t.index ["periodic_slot_blueprint_id"], name: "index_periodic_slots_on_periodic_slot_blueprint_id"
    t.index ["slot_id"], name: "index_periodic_slots_on_slot_id"
  end

  create_table "providers", force: :cascade do |t|
    t.bigint "app_user_id", null: false
    t.boolean "isverified", default: false, null: false
    t.integer "maxstrikes", default: 1, null: false
    t.string "companyname"
    t.index ["app_user_id"], name: "index_providers_on_app_user_id", unique: true
    t.check_constraint "maxstrikes > 0", name: "maxstrikes_constraint"
  end

  create_table "ratings", force: :cascade do |t|
    t.float "rating", null: false
    t.text "comment"
    t.bigint "establishment_id", null: false
    t.bigint "client_id", null: false
    t.index ["client_id"], name: "index_ratings_on_client_id"
    t.index ["establishment_id"], name: "index_ratings_on_establishment_id"
    t.check_constraint "rating >= 1::double precision AND rating <= 5::double precision", name: "rating_constraint"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "slot_id", null: false
    t.index ["slot_id", "client_id"], name: "one_per_client", unique: true
  end

  create_table "slot_blueprints", force: :cascade do |t|
    t.integer "weekdays", null: false
    t.integer "reservationlimit"
    t.date "fromdate", default: -> { "now()" }, null: false
    t.date "todate"
    t.bigint "establishment_id", null: false
    t.index ["establishment_id"], name: "index_slot_blueprints_on_establishment_id"
    t.check_constraint "reservationlimit IS NULL OR reservationlimit > 0", name: "valid_limit"
    t.check_constraint "weekdays > 0 AND weekdays <= '1111111'::\"bit\"::integer", name: "valid_weekdays"
  end

  create_table "slots", force: :cascade do |t|
    t.string "password_digest"
    t.date "date", null: false
    t.bigint "app_user_id", null: false
  end

  create_table "strikes", force: :cascade do |t|
    t.string "usercellphone", limit: 13
    t.integer "count", default: 1, null: false
    t.bigint "provider_id", null: false
    t.index ["provider_id"], name: "index_strikes_on_provider_id"
    t.index ["usercellphone", "provider_id"], name: "one_per_client_provider_strikes", unique: true
    t.check_constraint "count > 0", name: "strike_count_constraint"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "unique_name", unique: true
  end

  add_foreign_key "blacklists", "providers", on_update: :cascade, on_delete: :cascade
  add_foreign_key "clients", "app_users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "establishments", "providers", on_update: :cascade, on_delete: :cascade
  add_foreign_key "manual_slot_blueprints", "slot_blueprints", on_update: :cascade, on_delete: :cascade
  add_foreign_key "manual_slots", "manual_slot_blueprints", on_update: :cascade, on_delete: :cascade
  add_foreign_key "manual_slots", "slots", on_update: :cascade, on_delete: :cascade
  add_foreign_key "periodic_slot_blueprints", "slot_blueprints", on_update: :cascade, on_delete: :cascade
  add_foreign_key "periodic_slots", "periodic_slot_blueprints", on_update: :cascade, on_delete: :cascade
  add_foreign_key "periodic_slots", "slots", on_update: :cascade, on_delete: :cascade
  add_foreign_key "providers", "app_users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "ratings", "clients", on_update: :cascade, on_delete: :cascade
  add_foreign_key "ratings", "establishments", on_update: :cascade, on_delete: :cascade
  add_foreign_key "reservations", "clients", on_update: :cascade, on_delete: :cascade
  add_foreign_key "reservations", "slots", on_update: :cascade, on_delete: :cascade
  add_foreign_key "slot_blueprints", "establishments"
  add_foreign_key "slots", "app_users", on_update: :cascade
  add_foreign_key "strikes", "providers", on_update: :cascade, on_delete: :cascade
end
