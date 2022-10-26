class Provider < ApplicationRecord
  belongs_to :app_user
  has_many :blacklists
end
