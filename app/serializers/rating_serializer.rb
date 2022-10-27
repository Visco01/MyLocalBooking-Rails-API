class RatingSerializer < ActiveModel::Serializer
  attributes :id, :rating, :comment
  has_one :establishment
  has_one :client
end
