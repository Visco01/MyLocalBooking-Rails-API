require "test_helper"

class ManualSlotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manual_slot = manual_slots(:one)
  end

  test "should get index" do
    get manual_slots_url, as: :json
    assert_response :success
  end

  test "should create manual_slot" do
    assert_difference("ManualSlot.count") do
      post manual_slots_url, params: { manual_slot: { fromtime: @manual_slot.fromtime, manual_slot_blueprint_id: @manual_slot.manual_slot_blueprint_id, slot_id: @manual_slot.slot_id, totime: @manual_slot.totime } }, as: :json
    end

    assert_response :created
  end

  test "should show manual_slot" do
    get manual_slot_url(@manual_slot), as: :json
    assert_response :success
  end

  test "should update manual_slot" do
    patch manual_slot_url(@manual_slot), params: { manual_slot: { fromtime: @manual_slot.fromtime, manual_slot_blueprint_id: @manual_slot.manual_slot_blueprint_id, slot_id: @manual_slot.slot_id, totime: @manual_slot.totime } }, as: :json
    assert_response :success
  end

  test "should destroy manual_slot" do
    assert_difference("ManualSlot.count", -1) do
      delete manual_slot_url(@manual_slot), as: :json
    end

    assert_response :no_content
  end
end
