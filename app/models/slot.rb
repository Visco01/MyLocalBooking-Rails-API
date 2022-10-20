class Slot < ApplicationRecord
  has_secure_password

  belongs_to :app_user
end
