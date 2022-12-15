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
    client_lat = request.params[:lat]
    client_lng = request.params[:lng]
    range = request.params[:range]
    establishments = Establishment.all

    closest_establishments = Array.new

    establishments.each do |elem|
      sql = <<-SQL
        select get_coordinates_distance_meters(#{request.params[:lat]}, #{request.params[:lng]}, #{elem.lat}, #{elem.lng});
      SQL
      result = execute_statement(sql)['get_coordinates_distance_meters']

      if result <= range
        closest_establishments.push(elem)
      end
    end

    # closest_establishments.each do |elem|
    #   print "\n\n#{elem}\n\n"
    # end

    render json: closest_establishments, status: 200
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
end
