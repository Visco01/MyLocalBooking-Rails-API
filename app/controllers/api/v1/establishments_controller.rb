class Api::V1::EstablishmentsController < Api::V1::BaseController
  before_action :set_establishment, only: %i[ show update destroy ]

  # GET /establishments
  def index
    @establishments = Establishment.all

    render json: @establishments
  end

  # GET /establishments/1
  def show
    render json: @establishment
  end

  # POST /establishments
  def create
    @establishment = Establishment.new(name: request.params[:name],
                                       provider_id: request.params[:provider_id],
                                       lat: request.params[:lat],
                                       lng: request.params[:lng],
                                       place_id: request.params[:place_id],
                                       address: request.params[:address])

    if @establishment.save
      render json: { status: "Created" }, status: :created, location: @establishment
    else
      render json: @establishment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /establishments/1
  def update
    if @establishment.update(establishment_params)
      render json: @establishment
    else
      render json: @establishment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /establishments/1
  def destroy
    @establishment.destroy
  end

  def establishments_by_provider_id
    establishments = Establishment.where(provider_id: params[:provider_id])
    if not establishments.nil?
      render json: establishments
    else
      render json: {status: "not found"}, status: :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_establishment
      @establishment = Establishment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def establishment_params
      params.require(:establishment).permit(:name, :provider_id, :lat, :long)
    end
end
