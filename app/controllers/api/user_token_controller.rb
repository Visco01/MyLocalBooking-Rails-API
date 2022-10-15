class Api::UserTokenController < Knock::AuthTokenController
  private
  def auth_params
    # Without overriding the auth_params here, you get "unpermitted
    #   parameter" errors for username. The call seems to work anyway,
    #   but this eliminates the error message from your logs.
    params.require(:auth).permit(:username, :password)
  end
end
