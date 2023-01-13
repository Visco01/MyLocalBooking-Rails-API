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

    periodic_policy = Establishment.find(establishment_id).has_periodic_policy
    sql = nil
    if periodic_policy
      sql = "select * from get_periodic_reservations_by_date(#{establishment_id}, #{date});"
    else
      sql = "select * from get_manual_reservations_by_date(#{establishment_id}, #{date});"
    end

    result = ActiveRecord::Base.connection.execute(sql).values

    if not result[0].nil?
      json = []
      slot_id = result[0][0]
      k = 0
      j = -1
      result.each_with_index do |elem, index|
        if slot_id != result[index][0] or index.zero?
          slot_id = result[index][0]
          j += 1
          k = 0
          json.push
          json[j] = {}

          json[j]['id'] = elem[0]
          json[j]['subclass_id'] = elem[15]
          json[j]['type'] = 'periodic' if periodic_policy
          json[j]['type'] = 'manual' unless periodic_policy
          json[j]['date'] = elem[2].to_s
          json[j]['password_digest'] = elem[1]
          json[j]['owner_cellphone'] = elem[3]

          unless periodic_policy
            json[j]['from_time'] = elem[16]
            json[j]['to_time'] = elem[17]
          end

          json[j]['reservations'] = []
        end
        json[j]['reservations'].push
        json[j]['reservations'][k] = {}
        json[j]['reservations'][k]['id'] = elem[4]
        json[j]['reservations'][k]['subclass_id'] = elem[11]
        json[j]['reservations'][k]['cellphone'] = elem[5]
        json[j]['reservations'][k]['password_digest'] = elem[6]
        json[j]['reservations'][k]['firstname'] = elem[8]
        json[j]['reservations'][k]['lastname'] = elem[9]
        json[j]['reservations'][k]['email'] = elem[7]
        json[j]['reservations'][k]['dob'] = elem[10]
        json[j]['reservations'][k]['coordinates'] = {}
        json[j]['reservations'][k]['coordinates']['lat'] = elem[12]
        json[j]['reservations'][k]['coordinates']['lng'] = elem[13]
        k += 1
        # print "\n\n #{slot_id} \n\n"
        # print "\n\n #{json[j]} \n\n"

      end
    end
    render json: json, status: 200
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
