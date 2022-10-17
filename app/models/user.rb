class User < ApplicationRecord
  has_secure_password

  def self.from_token_request(request)
    User.find_by(name: request.params[:auth][:username])
  end

  def authenticate(password)
    # Do your custom authentication here.
    # Return `true` if the auth should succeed, or `false` if it should fail.
    User.find_by(password_digest: password)
  end
end
