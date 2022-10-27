class Establishment < ApplicationRecord
  belongs_to :provider
  has_many :ratings
  has_many :slot_blueprints
end
