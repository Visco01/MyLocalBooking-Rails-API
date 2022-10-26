require "test_helper"

class StrikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @strike = strikes(:one)
  end

  test "should get index" do
    get strikes_url, as: :json
    assert_response :success
  end

  test "should create strike" do
    assert_difference("Strike.count") do
      post strikes_url, params: { strike: { count: @strike.count, provider_id: @strike.provider_id, usercellphone: @strike.usercellphone } }, as: :json
    end

    assert_response :created
  end

  test "should show strike" do
    get strike_url(@strike), as: :json
    assert_response :success
  end

  test "should update strike" do
    patch strike_url(@strike), params: { strike: { count: @strike.count, provider_id: @strike.provider_id, usercellphone: @strike.usercellphone } }, as: :json
    assert_response :success
  end

  test "should destroy strike" do
    assert_difference("Strike.count", -1) do
      delete strike_url(@strike), as: :json
    end

    assert_response :no_content
  end
end
