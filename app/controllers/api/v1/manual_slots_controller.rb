class Api::V1::ManualSlotsController < Api::V1::BaseController
  before_action :set_manual_slot, only: %i[ show update destroy ]

  # GET /manual_slots
  def index
    @manual_slots = ManualSlot.all

    render json: @manual_slots
  end

  # GET /manual_slots/1
  def show
    render json: @manual_slot
  end

  # POST /manual_slots
  def create
    @manual_slot = ManualSlot.new(manual_slot_params)

    if @manual_slot.save
      render json: @manual_slot, status: :created, location: @manual_slot
    else
      render json: @manual_slot.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /manual_slots/1
  def update
    if @manual_slot.update(manual_slot_params)
      render json: @manual_slot
    else
      render json: @manual_slot.errors, status: :unprocessable_entity
    end
  end

  # DELETE /manual_slots/1
  def destroy
    @manual_slot.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manual_slot
      @manual_slot = ManualSlot.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def manual_slot_params
      params.require(:manual_slot).permit(:fromtime, :totime, :slot_id, :manual_slot_blueprint_id)
    end
end
