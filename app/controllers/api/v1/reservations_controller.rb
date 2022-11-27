class Api::V1::ReservationsController < Api::V1::BaseController
  before_action :set_reservation, only: %i[ show update destroy ]

  # GET /reservations
  def index
    @reservations = Reservation.all

    render json: @reservations
  end

  # GET /reservations/1
  def show
    render json: @reservation
  end

  # POST /reservations
  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      # render json: @reservation, status: :created
      render json: { status: "OK" }, status: :created
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reservations/1
  def update
    if @reservation.update(reservation_params)
      render json: @reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reservations/1
  def destroy
    @reservation.destroy
  end

  def delete_reservation_by_ids
    @reservation = Reservation.find_by(client_id: request.params[:client_id], slot_id: request.params[:slot_id])
    if @reservation.destroy
      slot_id = nil
      slot_id = Slot.find(request.params[:slot_id]).id
      if slot_id.nil?
        render json: { status: "OK", slot_id: "-1" }, status: 200
      else
        render json: { status: "OK", slot_id: "#{slot_id}" }, status: 200
      end
    else
      render json: { status: "Unprocessable Entity" }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:client_id, :slot_id)
    end
end
