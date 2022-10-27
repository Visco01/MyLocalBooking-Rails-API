class ManualSlotBlueprintSerializer < ActiveModel::Serializer
  attributes :id, :opentime, :closetime, :maxduration
  has_one :slot_blueprint
end
