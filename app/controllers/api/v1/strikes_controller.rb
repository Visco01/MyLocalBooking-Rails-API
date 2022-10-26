class Api::V1::StrikesController < Api::V1::BaseController
  before_action :set_strike, only: %i[ show update destroy ]

  # GET /strikes
  def index
    @strikes = Strike.all

    render json: @strikes
  end

  # GET /strikes/1
  def show
    render json: @strike
  end

  # POST /strikes
  def create
    @strike = Strike.new(strike_params)

    if @strike.save
      render json: @strike, status: :created, location: @strike
    else
      render json: @strike.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /strikes/1
  def update
    if @strike.update(strike_params)
      render json: @strike
    else
      render json: @strike.errors, status: :unprocessable_entity
    end
  end

  # DELETE /strikes/1
  def destroy
    @strike.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_strike
      @strike = Strike.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def strike_params
      params.require(:strike).permit(:usercellphone, :count, :provider_id)
    end
end
