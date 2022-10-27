class ClientSerializer < ActiveModel::Serializer
  attributes :id, :lat, :lng
  belongs_to :app_user
  # has_many :reservations
  # has_many :slots, through: :reservations
end
