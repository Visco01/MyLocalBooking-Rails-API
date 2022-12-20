class SlotBlueprintSerializer < ActiveModel::Serializer
  attributes :id, :weekdays, :reservationlimit, :fromdate, :todate, :periodic_slot_blueprints, :manual_slot_blueprints
  # has_one :establishment

  def periodic_slot_blueprints
    PeriodicSlotBlueprint.where(slot_blueprint_id: object.id)
  end

  def manual_slot_blueprints
    ManualSlotBlueprint.where(slot_blueprint_id: object.id)
  end

end
