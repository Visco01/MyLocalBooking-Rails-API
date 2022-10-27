class PeriodicSlotBlueprint < ApplicationRecord
  belongs_to :slot_blueprint
  has_many :periodic_slots
end
