class EstablishmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :lat, :lng, :address, :place_id, :provider_id
  has_many :slot_blueprints
  # has_one :provider

  def app_user
    app_user = AppUser.find(object.id)
    AppUserSerializer.new(app_user, without_serializer: true)
  end

  # def slot_blueprints
  #   object.slot_blueprints
  # end

end
