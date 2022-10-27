class CreateSlotBlueprints < ActiveRecord::Migration[7.0]
  def change
    create_table :slot_blueprints do |t|
      t.integer :weekdays
      t.integer :reservationlimit
      t.date :fromdate
      t.date :todate
      t.references :establishment, null: false, foreign_key: true
    end
  end
end
