class ProviderSerializer < ActiveModel::Serializer
  attributes :id, :app_user_id, :isverified, :maxstrikes, :companyname
  belongs_to :app_user
end
