class AddMaxDurationToMsb < ActiveRecord::Migration[7.0]
  def change
    add_column :manual_slot_blueprints, :maxduration, :time
  end
end
