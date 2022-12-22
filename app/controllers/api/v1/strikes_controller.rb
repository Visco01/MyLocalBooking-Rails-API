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
    new_strike = Strike.new(strike_params)
    old_strike = Strike.find_by(provider_id: new_strike.provider_id, usercellphone: new_strike.usercellphone)

    if !old_strike.nil?
      old_strike.count += 1
      update_strike(old_strike)
    else
      new_strike.count = 1
      save_strike(new_strike)
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
      params.require(:strike).permit(:usercellphone, :provider_id)
    end

    def save_strike(strike)
      if strike.save
        render json: strike, status: :created
      else
        render json: strike.errors, status: :unprocessable_entity
      end
    end

    def update_strike(strike)
      if strike.update(count: strike.count)
        render json: strike, status: :created
      else
        render json: strike.errors, status: :unprocessable_entity
      end
    end

end
