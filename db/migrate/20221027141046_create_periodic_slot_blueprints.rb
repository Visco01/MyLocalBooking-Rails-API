class CreatePeriodicSlotBlueprints < ActiveRecord::Migration[7.0]
  def change
    create_table :periodic_slot_blueprints do |t|
      t.time :fromtime
      t.time :totime
      t.references :slot_blueprint, null: false, foreign_key: true
    end
  end
end
