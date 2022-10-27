class ManualSlotSerializer < ActiveModel::Serializer
  attributes :id, :fromtime, :totime
  has_one :slot
  has_one :manual_slot_blueprint
end
