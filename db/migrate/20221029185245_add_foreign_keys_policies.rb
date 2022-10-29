class AddForeignKeysPolicies < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :clients, :app_users
    add_foreign_key :clients, :app_users, on_delete: :cascade, on_update: :cascade

    remove_foreign_key :providers, :app_users
    add_foreign_key :providers, :app_users, on_delete: :cascade, on_update: :cascade

    remove_foreign_key :blacklists, :providers
    add_foreign_key :blacklists, :providers, on_delete: :cascade, on_update: :cascade

    remove_foreign_key :strikes, :providers
    add_foreign_key :strikes, :providers, on_delete: :cascade, on_update: :cascade

    remove_foreign_key :establishments, :providers
    add_foreign_key :establishments, :providers, on_delete: :cascade, on_update: :cascade

    remove_foreign_key :ratings, :clients
    add_foreign_key :ratings, :clients, on_delete: :cascade, on_update: :cascade

    remove_foreign_key :ratings, :establishments
    add_foreign_key :ratings, :establishments, on_delete: :cascade, on_update: :cascade

    remove_foreign_key :slots, :app_users
    add_foreign_key :slots, :app_users, on_update: :cascade

    remove_foreign_key :reservations, :slots
    add_foreign_key :reservations, :slots, on_delete: :cascade, on_update: :cascade

    remove_foreign_key :reservations, :clients
    add_foreign_key :reservations, :clients, on_delete: :cascade, on_update: :cascade

    remove_foreign_key :periodic_slot_blueprints, :slot_blueprints
    add_foreign_key :periodic_slot_blueprints, :slot_blueprints, on_delete: :cascade, on_update: :cascade

    remove_foreign_key :manual_slot_blueprints, :slot_blueprints
    add_foreign_key :manual_slot_blueprints, :slot_blueprints, on_delete: :cascade, on_update: :cascade

    remove_foreign_key :manual_slots, :slots
    add_foreign_key :manual_slots, :slots, on_delete: :cascade, on_update: :cascade

    remove_foreign_key :manual_slots, :manual_slot_blueprints
    add_foreign_key :manual_slots, :manual_slot_blueprints, on_delete: :cascade, on_update: :cascade

    remove_foreign_key :periodic_slots, :slots
    add_foreign_key :periodic_slots, :slots, on_delete: :cascade, on_update: :cascade

    remove_foreign_key :periodic_slots, :periodic_slot_blueprints
    add_foreign_key :periodic_slots, :periodic_slot_blueprints, on_delete: :cascade, on_update: :cascade

  end
end
