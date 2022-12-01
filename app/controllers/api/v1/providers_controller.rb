class Api::V1::ProvidersController < Api::V1::BaseController
  before_action :set_provider, only: %i[ show update destroy ]

  # GET /providers
  def index
    @providers = Provider.all

    render json: @providers
  end

  # GET /providers/1
  def show
    render json: @provider
  end

  # POST /providers
  def create
    @provider = Provider.new(provider_params)

    if @provider.save
      render json: @provider, status: :created, location: @provider
    else
      render json: @provider.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /providers/1
  def update
    if @provider.update(provider_params)
      render json: @provider
    else
      render json: @provider.errors, status: :unprocessable_entity
    end
  end

  # DELETE /providers/1
  def destroy
    @provider.destroy
  end

  def provider_by_app_user_id
    provider = Provider.find_by(app_user_id: params[:app_user_id])
    if not provider.nil?
      render json: { status: "OK", provider_id: "#{provider.id}" }
    else
      render json: { provider_id: client }, status: :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_provider
      @provider = Provider.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def provider_params
      params.require(:provider).permit(:isverified, :maxstrikes, :companyname)
    end
end
