class Api::V1::EstablishmentsController < Api::V1::BaseController
  before_action :set_establishment, only: %i[ show update destroy ]

  # GET /establishments
  def index
    @establishments = Establishment.all

    render json: @establishments
  end

  # GET /establishments/1
  def show
    render json: @establishment
  end

  # POST /establishments
  def create
    @establishment = Establishment.new(name: request.params[:name],
                                       provider_id: request.params[:provider_id],
                                       lat: request.params[:lat],
                                       lng: request.params[:lng],
                                       place_id: request.params[:place_id],
                                       address: request.params[:address])

    if @establishment.save
      render json: { status: "Created" }, status: :created, location: @establishment
    else
      render json: @establishment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /establishments/1
  def update
    if @establishment.update(establishment_params)
      render json: @establishment
    else
      render json: @establishment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /establishments/1
  def destroy
    @establishment.destroy
  end

  def establishments_by_provider_id
    establishments = Establishment.where(provider_id: params[:provider_id])
    if not establishments.nil?
      json = []
      establishments.each_with_index do |est, i|
        # print "\n\n#{get_slot_blueprints_by_est(est.id, est.has_periodic_policy).values}"
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

      render json: json
    else
      render json: {status: "not found"}, status: :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_establishment
      @establishment = Establishment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def establishment_params
      params.require(:establishment).permit(:name, :provider_id, :lat, :long)
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
end
