class SlotBlueprintSerializer < ActiveModel::Serializer
  attributes :id, :weekdays, :reservationlimit, :fromdate, :todate, :periodic_slot_blueprint, :manual_slot_blueprint
  # has_one :establishment

  def periodic_slot_blueprint
    object.periodic_slot_blueprint
  end

  def manual_slot_blueprint
    object.manual_slot_blueprint
  end

end
