class AppUserSerializer < ActiveModel::Serializer
  attributes :id, :cellphone, :password_digest, :email, :firstname, :lastname, :dob
  has_one :Provider
  has_one :Client
end
