class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :client_id, :slot_id
  belongs_to :client
  belongs_to :slot
end
