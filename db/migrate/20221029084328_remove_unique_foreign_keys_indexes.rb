class RemoveUniqueForeignKeysIndexes < ActiveRecord::Migration[7.0]
  def change
    remove_index :reservations, name: "index_reservations_on_slot_id"
    remove_index :reservations, name: "index_reservations_on_client_id"
    remove_index :slots, name: "index_slots_on_app_user_id"
  end
end
