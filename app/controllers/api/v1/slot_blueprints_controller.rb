class Api::V1::SlotBlueprintsController < Api::V1::BaseController
  before_action :set_slot_blueprint, only: %i[ show update destroy ]

  # GET /slot_blueprints
  def index
    @slot_blueprints = SlotBlueprint.all

    render json: @slot_blueprints
  end

  # GET /slot_blueprints/1
  def show
    render json: @slot_blueprint
  end

  # POST /slot_blueprints
  def create
    @slot_blueprint = SlotBlueprint.new(slot_blueprint_params)

    if @slot_blueprint.save
      render json: @slot_blueprint, status: :created, location: @slot_blueprint
    else
      render json: @slot_blueprint.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /slot_blueprints/1
  def update
    if @slot_blueprint.update(slot_blueprint_params)
      render json: @slot_blueprint
    else
      render json: @slot_blueprint.errors, status: :unprocessable_entity
    end
  end

  # DELETE /slot_blueprints/1
  def destroy
    @slot_blueprint.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slot_blueprint
      @slot_blueprint = SlotBlueprint.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def slot_blueprint_params
      params.require(:slot_blueprint).permit(:weekdays, :reservationlimit, :fromdate, :todate, :establishment_id)
    end
end
