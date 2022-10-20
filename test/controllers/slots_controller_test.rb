require "test_helper"

class SlotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @slot = slots(:one)
  end

  test "should get index" do
    get slots_url, as: :json
    assert_response :success
  end

  test "should create slot" do
    assert_difference("Slot.count") do
      post slots_url, params: { slot: { app_user_id: @slot.app_user_id, date: @slot.date, password_digest: @slot.password_digest } }, as: :json
    end

    assert_response :created
  end

  test "should show slot" do
    get slot_url(@slot), as: :json
    assert_response :success
  end

  test "should update slot" do
    patch slot_url(@slot), params: { slot: { app_user_id: @slot.app_user_id, date: @slot.date, password_digest: @slot.password_digest } }, as: :json
    assert_response :success
  end

  test "should destroy slot" do
    assert_difference("Slot.count", -1) do
      delete slot_url(@slot), as: :json
    end

    assert_response :no_content
  end
end
