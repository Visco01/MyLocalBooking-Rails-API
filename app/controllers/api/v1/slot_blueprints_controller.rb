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
    # @slot_blueprint = SlotBlueprint.new(slot_blueprint_params)

    # if @slot_blueprint.save
    #   render json: @slot_blueprint, status: :created, location: @slot_blueprint
    # else
    #   render json: @slot_blueprint.errors, status: :unprocessable_entity
    # end

    begin
      json_object = request.params
      connection = ActiveRecord::Base.connection.raw_connection

      unless json_object[:PeriodicSlotBlueprint].nil?

        begin
          insert_periodic_slot_blueprint(json_object)
        rescue PG::InvalidSqlStatementName => e
          connection.prepare('insert_periodic_slot_blueprint', 'CALL insert_periodic_slot_blueprint($1, $2, $3, $4, $5, $6, $7)')
          insert_periodic_slot_blueprint(json_object)
        end

      end

      unless json_object[:ManualSlotBlueprint].nil?

        begin
          insert_manual_slot_blueprint(json_object)
        rescue PG::InvalidSqlStatementName => e
          connection.prepare('insert_manual_slot_blueprint', 'CALL insert_manual_slot_blueprint($1, $2, $3, $4, $5, $6, $7, $8)')
          insert_manual_slot_blueprint(json_object)
        end

      end

      render json: 'SlotBlueprint created successfully', status: :created
    rescue => e
      render json: "#{e.class}, #{e.message}", status: :unprocessable_entity
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

    # IN establishment_id bigint, IN weekdays integer, IN reservationlimit integer, IN fromdate date, IN todate date, IN fromtime time, IN totime time
    def insert_periodic_slot_blueprint(json_object)
      connection = ActiveRecord::Base.connection.raw_connection
      connection.exec_prepared('insert_periodic_slot_blueprint',
                               [json_object[:establishment_id],
                                json_object[:weekdays],
                                json_object[:reservationlimit],
                                json_object[:fromdate],
                                json_object[:todate],
                                json_object[:PeriodicSlotBlueprint][:fromtime],
                                json_object[:PeriodicSlotBlueprint][:totime]])
    end

    def insert_manual_slot_blueprint(json_object)
      connection = ActiveRecord::Base.connection.raw_connection
      connection.exec_prepared('insert_manual_slot_blueprint',
                               [json_object[:establishment_id],
                                json_object[:weekdays],
                                json_object[:reservationlimit],
                                json_object[:fromdate],
                                json_object[:todate],
                                json_object[:ManualSlotBlueprint][:opentime],
                                json_object[:ManualSlotBlueprint][:closetime],
                                json_object[:ManualSlotBlueprint][:maxduration]])
    end
end
