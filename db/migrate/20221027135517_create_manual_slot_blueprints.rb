class CreateManualSlotBlueprints < ActiveRecord::Migration[7.0]
  def change
    create_table :manual_slot_blueprints do |t|
      t.time :opentime
      t.time :closetime
      t.references :slot_blueprint, null: false, foreign_key: true
    end
  end
end
