class RenameToAllTables < ActiveRecord::Migration[7.0]
  def change
    rename_table :manual_blueprints, :manual_slot_blueprints
    rename_table :periodic_blueprints, :periodic_slot_blueprints
    rename_table :blueprints, :slot_blueprints
  end
end
