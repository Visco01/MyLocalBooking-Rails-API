class Api::V1::ClientsController < Api::V1::BaseController
  before_action :set_client, only: %i[ show update destroy ]

  # GET /clients
  def index
    @clients = Client.all

    render json: @clients
  end

  # GET /clients/1
  def show
    render json: @client
  end

  # POST /clients
  def create
    @client = Client.new(client_params)

    if @client.save
      render json: @client, status: :created, location: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /clients/1
  def update
    if @client.update(client_params)
      render json: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  def set_preferred_position
    client = Client.find(params[:id])
    if not client.nil?
      if client.update(lat: request.params[:lat], lng: request.params[:lng])
        render json: { status: "updated" }, status: 200
      else
        render json: { status: "unprocessable entity" }, status: :unprocessable_entity
      end
    else
      render json: { status: "not found" }, status: :not_found
    end
  end

  def closest_establishments
    client_lat = params[:lat].to_f
    client_lng = params[:lng].to_f
    range = params[:range].to_i

    establishments = Establishment.all

    closest_establishments_ids = Array.new

    establishments.each do |elem|
      sql = <<-SQL
        select get_coordinates_distance_meters(#{client_lat}, #{client_lng}, #{elem.lat}, #{elem.lng});
      SQL
      result = execute_statement(sql)['get_coordinates_distance_meters']

      if result <= range
        closest_establishments_ids.push(elem.id)
      end
    end

    json = get_establishments_json_response(Establishment.where(id: closest_establishments_ids))

    render json: json
  end

  # DELETE /clients/1
  def destroy
    @client.destroy
  end

  def client_by_app_user_id
    client = Client.find_by(app_user_id: params[:app_user_id])
    if not client.nil?
      render json: { status: "OK", client_id: "#{client.id}" }
    else
      render json: { client_id: client }, status: :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end



    # Only allow a list of trusted parameters through.
    def client_params
      params.fetch(:client, {})
    end

    def execute_statement(sql)
      results = ActiveRecord::Base.connection.execute(sql)[0]

      if results.present?
        return results
      else
        return nil
      end
    end

    def get_slot_blueprints_by_est(id, periodic_policy)
      slot_blueprints = nil
      if periodic_policy
        sql  = "select * from slot_blueprints sb
                inner join periodic_slot_blueprints psb
                on sb.id = psb.slot_blueprint_id
                where sb.establishment_id = #{id}"
        slot_blueprints = ActiveRecord::Base.connection.execute(sql)
        print "\n\n ooooo \n\n"
      else
        sql  = "select * from slot_blueprints sb
                inner join manual_slot_blueprints msb
                on sb.id = msb.slot_blueprint_id
                where sb.establishment_id = #{id}"
        slot_blueprints = ActiveRecord::Base.connection.execute(sql)
        print "\n\n aaaaa \n\n"
      end

      slot_blueprints
    end

    def get_establishments_json_response(establishments)
      json = []
      establishments.each_with_index do |est, i|
        json[i] = {}
        json[i]['id'] = est.id
        json[i]['provider_cellphone'] = AppUser.find(Provider.find(est.provider_id).app_user_id).cellphone
        json[i]['name'] = est.name
        json[i]['address'] = est.address
        json[i]['place_id'] = est.place_id
        json[i]['coordinates'] = {}
        json[i]['coordinates']['lat'] = est.lat
        json[i]['coordinates']['lng'] = est.lng

        json[i]['slot_blueprints'] = []
        slot_blueprints = get_slot_blueprints_by_est(est.id, est.has_periodic_policy)

        slot_blueprints.values.each_with_index do |slot, j|
          json[i]['slot_blueprints'][j] = {}
          json[i]['slot_blueprints'][j]['type'] = est.has_periodic_policy ? 'periodic' : 'manual'
          json[i]['slot_blueprints'][j]['id'] = slot[0]
          json[i]['slot_blueprints'][j]['weekdays'] = slot[1]
          json[i]['slot_blueprints'][j]['reservation_limit'] = slot[2]
          json[i]['slot_blueprints'][j]['from_date'] = slot[3]
          json[i]['slot_blueprints'][j]['to_date'] = slot[4]
          json[i]['slot_blueprints'][j]['subclass_id'] = slot[6]

          if est.has_periodic_policy
            json[i]['slot_blueprints'][j]['from_time'] = slot[7]
            json[i]['slot_blueprints'][j]['to_time'] = slot[8]
          else
            json[i]['slot_blueprints'][j]['open_time'] = slot[7]
            json[i]['slot_blueprints'][j]['close_time'] = slot[8]
            json[i]['slot_blueprints'][j]['max_duration'] = slot[10]
          end
        end
      end

      json
    end
end
