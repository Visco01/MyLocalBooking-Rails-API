class RenameManualSlotBlueprintsToManualBlueprints < ActiveRecord::Migration[7.0]
  def change
    rename_table :manual_slot_blueprints, :manual_blueprints
  end
end
