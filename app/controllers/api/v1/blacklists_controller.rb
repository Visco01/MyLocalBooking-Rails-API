class Api::V1::BlacklistsController < Api::V1::BaseController
  before_action :set_blacklist, only: %i[ show update destroy ]

  # GET /blacklists
  def index
    @blacklists = Blacklist.all

    render json: @blacklists
  end

  # GET /blacklists/1
  def show
    render json: @blacklist
  end

  # POST /blacklists
  def create
    @blacklist = Blacklist.new(blacklist_params)

    if @blacklist.save
      render json: @blacklist, status: :created, location: @blacklist
    else
      render json: @blacklist.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /blacklists/1
  def update
    if @blacklist.update(blacklist_params)
      render json: @blacklist
    else
      render json: @blacklist.errors, status: :unprocessable_entity
    end
  end

  # DELETE /blacklists/1
  def destroy
    @blacklist.destroy
  end

  def delete_blacklist_by_params
    blacklist = Blacklist.find_by(provider_id: request.params[:provider_id], usercellphone: request.params[:usercellphone])
    if not blacklist.nil?
      blacklist.destroy
    else
      render json: { "error": "not_found" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blacklist
      @blacklist = Blacklist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blacklist_params
      params.require(:blacklist).permit(:usercellphone, :provider_id)
    end
end
