class SlotBlueprintSerializer < ActiveModel::Serializer
  attributes :id, :weekdays, :reservationlimit, :fromdate, :todate
  has_one :establishment
end
