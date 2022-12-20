class SlotBlueprint < ApplicationRecord
  belongs_to :establishment
  has_many :manual_slot_blueprint
  has_many :periodic_slot_blueprint
end
