class Api::V1::PeriodicSlotBlueprintsController < Api::V1::BaseController
  before_action :set_periodic_slot_blueprint, only: %i[ show update destroy ]

  # GET /periodic_slot_blueprints
  def index
    @periodic_slot_blueprints = PeriodicSlotBlueprint.all

    render json: @periodic_slot_blueprints
  end

  # GET /periodic_slot_blueprints/1
  def show
    render json: @periodic_slot_blueprint
  end

  # POST /periodic_slot_blueprints
  def create
    @periodic_slot_blueprint = PeriodicSlotBlueprint.new(periodic_slot_blueprint_params)

    if @periodic_slot_blueprint.save
      render json: @periodic_slot_blueprint, status: :created, location: @periodic_slot_blueprint
    else
      render json: @periodic_slot_blueprint.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /periodic_slot_blueprints/1
  def update
    if @periodic_slot_blueprint.update(periodic_slot_blueprint_params)
      render json: @periodic_slot_blueprint
    else
      render json: @periodic_slot_blueprint.errors, status: :unprocessable_entity
    end
  end

  # DELETE /periodic_slot_blueprints/1
  def destroy
    @periodic_slot_blueprint.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_periodic_slot_blueprint
      @periodic_slot_blueprint = PeriodicSlotBlueprint.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def periodic_slot_blueprint_params
      params.require(:periodic_slot_blueprint).permit(:fromtime, :totime, :slot_blueprint_id)
    end
end
