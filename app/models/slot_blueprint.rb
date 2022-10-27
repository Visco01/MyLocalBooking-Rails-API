class SlotBlueprint < ApplicationRecord
  belongs_to :establishment
  has_many :manual_slot_blueprints
  has_many :periodic_slot_blueprints
end
