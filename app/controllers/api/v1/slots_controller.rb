class Api::V1::SlotsController < Api::V1::BaseController
  before_action :set_slot, only: %i[ show update destroy ]

  # GET /slots
  def index
    @slots = Slot.all

    render json: @slots
  end

  # GET /slots/1
  def show
    render json: @slot
  end

  # POST /slots
  def create
    # @slot = Slot.new(slot_params)

    # if @slot.save
    #   render json: @slot, status: :created, location: @slot
    # else
    #   render json: @slot.errors, status: :unprocessable_entity
    # end

    begin
      json_object = request.params
      concrete_slot = nil
      connection = ActiveRecord::Base.connection.raw_connection

      unless json_object[:PeriodicSlot].nil?

        begin
          insert_periodic_slot(json_object)
        rescue PG::InvalidSqlStatementName => e
          connection.prepare('insert_periodic_slot', 'CALL insert_periodic_slot($1, $2, $3, $4)')
          insert_periodic_slot(json_object)
        end

        concrete_slot = PeriodicSlot.last

      end

      unless json_object[:ManualSlot].nil?

        begin
          insert_manual_slot(json_object)
        rescue PG::InvalidSqlStatementName => e
          connection.prepare('insert_manual_slot', 'CALL insert_manual_slot($1, $2, $3, $4, $5, $6)')
          insert_manual_slot(json_object)
        end

        concrete_slot = ManualSlot.last

      end

      render json: { slot_id: "#{Slot.last.id}", concrete_slot_id: "#{concrete_slot.last.id}" }, status: :created
    rescue => e
      render json: "#{e.class}, #{e.message}", status: :unprocessable_entity
    end
  end

  def change_slot_password
    @slot = Slot.find(params[:id])
    @slot.password_digest = request.params[:new_password]
    if @slot.save
      render json: {status: "OK"}, status: :created
    else
      render json: @slot.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /slots/1
  def update
    if @slot.update(slot_params)
      render json: @slot
    else
      render json: @slot.errors, status: :unprocessable_entity
    end
  end

  # DELETE /slots/1
  def destroy
    @slot.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_slot
    @slot = Slot.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def slot_params
    params.require(:slot).permit(:password_digest, :date, :app_user_id)
  end

  # IN app_user_id bigint, IN date date, IN password_digest text, IN periodic_slot_blueprint_id bigint
  def insert_periodic_slot(json_object)
    connection = ActiveRecord::Base.connection.raw_connection
    connection.exec_prepared('insert_periodic_slot',
                             [json_object[:app_user_id], json_object[:date], json_object[:password_digest], json_object[:PeriodicSlot][:periodic_slot_blueprint_id]])
  end

  # IN app_user_id bigint, IN date date, IN password_digest text, IN manual_slot_blueprint_id bigint, IN fromtime time without time zone, IN totime time
  def insert_manual_slot(json_object)
    connection = ActiveRecord::Base.connection.raw_connection
    connection.exec_prepared('insert_manual_slot',
                             [json_object[:app_user_id], json_object[:date], json_object[:password_digest], json_object[:ManualSlot][:manual_slot_blueprint_id],
                              json_object[:fromtime], json_object[:totime]])
  end
end
