class Slot < ApplicationRecord
  has_secure_password

  belongs_to :app_user
  has_many :reservations
  has_many :clients, through: :reservations
  has_one :ManualSlot
  has_one :PeriodicSlot
end
