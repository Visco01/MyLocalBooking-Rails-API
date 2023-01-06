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

  def reservations_by_slot_id
    reservations = Reservation.where(slot_id: params[:slot_id])
    render json: reservations
  end

  def get_reservations_by_day
    establishment_id = params[:establishment_id].to_i
    date = params[:date].to_s

    periodic_policy = Establishment.find(establishment_id)
    sql = nil
    if periodic_policy
      sql = "select * from get_periodic_reservations_by_date(#{establishment_id}, #{date});"
    else
      sql = "select * from get_manual_reservations_by_date(#{establishment_id}, #{date});"
    end

    result = ActiveRecord::Base.connection.execute(sql).values

    json = {}

    if not result[0].nil?
      json['blueprint_subclass_id'] = result[0]['periodic_slot_blueprint_id']
      json['date'] = result[0]['date']
      json['password_digest'] = result[0]['slot_password_digest']
      json['owner_cellphone'] = result[0]['owner_cellphone']

      unless periodic_policy
        json['fromtime'] = result[0]['from_time']
        json['totime'] = result[0]['to_time']
      end
    end

    json['reservations'] = []
    result.each_with_index do |elem, index|
      json['reservations'].push
      json['reservations'][index] = {}
      json['reservations'][index]['id'] = elem['app_user_id']
      json['reservations'][index]['subclass_id'] = elem['client_id']
      json['reservations'][index]['cellphone'] = elem['cellphone']
      json['reservations'][index]['password_digest'] = elem['user_password_digest']
      json['reservations'][index]['firstname'] = elem['firstname']
      json['reservations'][index]['lastname'] = elem['lastname']
      json['reservations'][index]['email'] = elem['email']
      json['reservations'][index]['dob'] = elem['dob']
      json['reservations'][index]['coordinates'] = {}
      json['reservations'][index]['coordinates']['lat'] = elem['lat']
      json['reservations'][index]['coordinates']['lng'] = elem['lng']
    end

    render json: json.to_json, status: 200
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
