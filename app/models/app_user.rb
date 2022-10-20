class AppUser < ApplicationRecord
  has_secure_password

  has_one :Client
  has_one :Provider
  has_many :slots
end
