class Provider < ApplicationRecord
  belongs_to :app_user
  has_many :blacklists
  has_many :strikes
  has_many :establishments
end
