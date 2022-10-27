class Rating < ApplicationRecord
  belongs_to :establishment
  belongs_to :client
end
