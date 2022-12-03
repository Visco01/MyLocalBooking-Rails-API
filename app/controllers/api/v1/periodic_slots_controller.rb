class Api::V1::PeriodicSlotsController < Api::V1::BaseController
  before_action :set_periodic_slot, only: %i[ show update destroy ]

  # GET /periodic_slots
  def index
    @periodic_slots = PeriodicSlot.all

    render json: @periodic_slots
  end

  # GET /periodic_slots/1
  def show
    render json: @periodic_slot
  end

  # POST /periodic_slots
  def create
    @periodic_slot = PeriodicSlot.new(periodic_slot_params)

    if @periodic_slot.save
      render json: @periodic_slot, status: :created, location: @periodic_slot
    else
      render json: @periodic_slot.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /periodic_slots/1
  def update
    if @periodic_slot.update(periodic_slot_params)
      render json: @periodic_slot
    else
      render json: @periodic_slot.errors, status: :unprocessable_entity
    end
  end

  # DELETE /periodic_slots/1
  def destroy
    @periodic_slot.destroy
  end

  def periodic_slot_by_blueprint_id
    periodic_slot = PeriodicSlot.find_by(periodic_slot_blueprint_id: params[:blueprint_id])
    if not periodic_slot.nil?
      render json: periodic_slot
    else
      render json: {status: "not found"}, status: :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_periodic_slot
      @periodic_slot = PeriodicSlot.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def periodic_slot_params
      params.require(:periodic_slot).permit(:slot_id, :periodic_slot_blueprint_id)
    end
end
