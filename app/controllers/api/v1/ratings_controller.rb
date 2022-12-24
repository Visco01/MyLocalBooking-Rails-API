class Api::V1::RatingsController < Api::V1::BaseController
  before_action :set_rating, only: %i[ show update destroy ]

  # GET /ratings
  def index
    @ratings = Rating.all

    render json: @ratings
  end

  # GET /ratings/1
  def show
    render json: @rating
  end

  # POST /ratings
  def create
    client_id = request.params[:client_id]
    establishment_id = request.params[:establishment_id]
    rating = request.params[:rating]
    comment = request.params[:comment]

    existing_rating = Rating.find_by(client_id: client_id, establishment_id: establishment_id)

    if existing_rating.nil?
      create_new_rating(client_id, establishment_id, comment, rating)
    else
      existing_rating.comment = comment
      existing_rating.rating = rating

      if existing_rating.save
        render json: { success: 'OK'}, status: :ok
      else
        render json: existing_rating.errors, status: :unprocessable_entity
      end

    end
  end

  # PATCH/PUT /ratings/1
  def update
    if @rating.update(rating_params)
      render json: @rating
    else
      render json: @rating.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ratings/1
  def destroy
    @rating.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rating_params
      params.require(:rating).permit(:rating, :comment, :establishment_id, :client_id)
    end

    def create_new_rating(client_id, establishment_id, comment, rating)
      rating_obj = Rating.new
      rating_obj.client_id = client_id
      rating_obj.establishment_id = establishment_id
      rating_obj.rating = rating
      rating_obj.comment = comment

      if rating_obj.save
        render json: { success: 'OK'}, status: :ok
      else
        render json: rating_obj.errors, status: :unprocessable_entity
      end

    end
end
