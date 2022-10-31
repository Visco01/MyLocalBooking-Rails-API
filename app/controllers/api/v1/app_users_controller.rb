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
    # @app_user = AppUser.new(app_user_params)
    # if @app_user.save
    #   render json: @app_user, status: :created, location: @app_user
    # else
    #   render json: @app_user.errors, status: :unprocessable_entity
    # end

    begin
      json_object = request.params
      connection = ActiveRecord::Base.connection.raw_connection

      unless json_object[:Client].nil?

        connection.exec_prepared("insert_client",
        [json_object[:password_digest], json_object[:cellphone],
        json_object[:email], json_object[:firstname],
        json_object[:lastname], json_object[:dob],
        json_object[:Client][:lat], json_object[:Client][:lng]])

      end

      unless request.params[:Provider].nil?

        connection.exec_prepared("insert_provider",
        [json_object[:password_digest], json_object[:cellphone],
        json_object[:email], json_object[:firstname],
        json_object[:lastname], json_object[:dob],
        json_object[:Provider][:isverified], json_object[:Provider][:maxstrikes], json_object[:Provider][:companyname]])

      end

      render json: 'User created successfully', status: :created
    rescue => e
      render json: "#{e.class}, #{e.message}", status: :unprocessable_entity
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
