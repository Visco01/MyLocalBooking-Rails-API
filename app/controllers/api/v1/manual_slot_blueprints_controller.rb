class Api::V1::ManualSlotBlueprintsController < Api::V1::BaseController
  before_action :set_manual_slot_blueprint, only: %i[ show update destroy ]

  # GET /manual_slot_blueprints
  def index
    @manual_slot_blueprints = ManualSlotBlueprint.all

    render json: @manual_slot_blueprints
  end

  # GET /manual_slot_blueprints/1
  def show
    render json: @manual_slot_blueprint
  end

  # POST /manual_slot_blueprints
  def create
    @manual_slot_blueprint = ManualSlotBlueprint.new(manual_slot_blueprint_params)

    if @manual_slot_blueprint.save
      render json: @manual_slot_blueprint, status: :created, location: @manual_slot_blueprint
    else
      render json: @manual_slot_blueprint.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /manual_slot_blueprints/1
  def update
    if @manual_slot_blueprint.update(manual_slot_blueprint_params)
      render json: @manual_slot_blueprint
    else
      render json: @manual_slot_blueprint.errors, status: :unprocessable_entity
    end
  end

  # DELETE /manual_slot_blueprints/1
  def destroy
    @manual_slot_blueprint.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manual_slot_blueprint
      @manual_slot_blueprint = ManualSlotBlueprint.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def manual_slot_blueprint_params
      params.require(:manual_slot_blueprint).permit(:opentime, :closetime, :slot_blueprint_id)
    end
end
