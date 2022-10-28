class RenameSlotBlueprintsToBlueprints < ActiveRecord::Migration[7.0]
  def change
    rename_table :slot_blueprints, :blueprints
  end
end
