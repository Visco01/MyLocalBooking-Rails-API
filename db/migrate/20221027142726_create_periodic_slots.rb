class CreatePeriodicSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :periodic_slots do |t|
      t.references :slot, null: false, foreign_key: true
      t.references :periodic_slot_blueprint, null: false, foreign_key: true
    end
  end
end
