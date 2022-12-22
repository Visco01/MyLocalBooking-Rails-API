class StrikeSerializer < ActiveModel::Serializer
  attributes :id, :usercellphone, :count
  has_one :provider

  # def app_user
  #   app_user = AppUser.find_by(cellphone: object.usercellphone)
  #   AppUserSerializer.new(app_user, without_serializer: true)
  # end
end
