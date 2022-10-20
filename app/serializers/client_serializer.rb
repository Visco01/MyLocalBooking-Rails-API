class ClientSerializer < ActiveModel::Serializer
  attributes :id, :app_user_id
  belongs_to :app_user
end
