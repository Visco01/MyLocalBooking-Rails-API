class EstablishmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :lat, :lng, :app_user
  # has_one :provider

  def app_user
    app_user = AppUser.find(object.id)
    AppUserSerializer.new(app_user, without_serializer: true)
  end

end
