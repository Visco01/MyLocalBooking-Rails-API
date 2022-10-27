class Establishment < ApplicationRecord
  belongs_to :provider
  has_many :ratings
end
