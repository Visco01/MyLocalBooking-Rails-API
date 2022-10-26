require "test_helper"

class EstablishmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @establishment = establishments(:one)
  end

  test "should get index" do
    get establishments_url, as: :json
    assert_response :success
  end

  test "should create establishment" do
    assert_difference("Establishment.count") do
      post establishments_url, params: { establishment: { name: @establishment.name, position: @establishment.position, provider_id: @establishment.provider_id } }, as: :json
    end

    assert_response :created
  end

  test "should show establishment" do
    get establishment_url(@establishment), as: :json
    assert_response :success
  end

  test "should update establishment" do
    patch establishment_url(@establishment), params: { establishment: { name: @establishment.name, position: @establishment.position, provider_id: @establishment.provider_id } }, as: :json
    assert_response :success
  end

  test "should destroy establishment" do
    assert_difference("Establishment.count", -1) do
      delete establishment_url(@establishment), as: :json
    end

    assert_response :no_content
  end
end
