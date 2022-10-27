class ManualSlot < ApplicationRecord
  belongs_to :slot
  belongs_to :manual_slot_blueprint
end
