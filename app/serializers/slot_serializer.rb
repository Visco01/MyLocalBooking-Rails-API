class SlotSerializer < ActiveModel::Serializer
  attributes :id, :password_digest, :date, :app_user_id
  belongs_to :app_user
  has_one :ManualSlot
  has_one :PeriodicSlot
  # has_many :reservations
  # has_many :clients, through: :reservations
end
