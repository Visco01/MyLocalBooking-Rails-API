class RenameBlueprintsTables < ActiveRecord::Migration[7.0]
  def change
    rename_table :periodic_slot_blueprints, :periodic_blueprints
  end
end
