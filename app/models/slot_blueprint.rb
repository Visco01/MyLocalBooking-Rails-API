class SlotBlueprint < ApplicationRecord
  belongs_to :establishment
  has_one :manual_slot_blueprint
  has_one :periodic_slot_blueprint
end
