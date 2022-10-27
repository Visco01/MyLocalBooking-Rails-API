class PeriodicSlotBlueprintSerializer < ActiveModel::Serializer
  attributes :id, :fromtime, :totime
  has_one :slot_blueprint
end
