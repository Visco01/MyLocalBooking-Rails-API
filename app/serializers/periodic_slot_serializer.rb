class PeriodicSlotSerializer < ActiveModel::Serializer
  attributes :id
  has_one :slot
  has_one :periodic_slot_blueprint
end
