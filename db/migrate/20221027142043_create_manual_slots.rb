class CreateManualSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :manual_slots do |t|
      t.time :fromtime
      t.time :totime
      t.references :slot, null: false, foreign_key: true
      t.references :manual_slot_blueprint, null: false, foreign_key: true
    end
  end
end
