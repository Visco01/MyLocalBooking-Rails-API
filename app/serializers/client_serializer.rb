class ClientSerializer < ActiveModel::Serializer
  attributes :id, :lat, :lng, :app_user
  belongs_to :app_user
  # has_many :reservations
  # has_many :slots, through: :reservations

  def app_user
    object.app_user
  end
end
