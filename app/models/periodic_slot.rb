class PeriodicSlot < ApplicationRecord
  belongs_to :slot
  belongs_to :periodic_slot_blueprint
end
