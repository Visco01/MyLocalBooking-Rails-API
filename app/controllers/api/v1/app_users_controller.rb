class Api::V1::AppUsersController < Api::V1::BaseController
  before_action :set_app_user, only: %i[ show update destroy ]

  # GET /app_users
  def index
    @app_users = AppUser.all

    render json: @app_users.includes(:Provider)
  end

  # GET /app_users/1
  def show
    render json: @app_user
  end

  # POST /app_users
  def create
    @app_user = AppUser.new(app_user_params)

    if @app_user.save
      render json: @app_user, status: :created, location: @app_user
    else
      render json: @app_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /app_users/1
  def update
    if @app_user.update(app_user_params)
      render json: @app_user
    else
      render json: @app_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /app_users/1
  def destroy
    @app_user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app_user
      @app_user = AppUser.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def app_user_params
      params.require(:app_user).permit(:cellphone, :password_digest, :email, :firstname, :lastname, :dob)
    end
end
