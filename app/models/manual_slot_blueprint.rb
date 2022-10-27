class ManualSlotBlueprint < ApplicationRecord
  belongs_to :slot_blueprint
  has_many :manual_slots
end
