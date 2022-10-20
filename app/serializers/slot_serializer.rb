class SlotSerializer < ActiveModel::Serializer
  attributes :id, :password_digest, :date, :app_user_id
  belongs_to :app_user
end
