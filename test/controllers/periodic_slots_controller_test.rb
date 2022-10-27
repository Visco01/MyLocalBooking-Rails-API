require "test_helper"

class PeriodicSlotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @periodic_slot = periodic_slots(:one)
  end

  test "should get index" do
    get periodic_slots_url, as: :json
    assert_response :success
  end

  test "should create periodic_slot" do
    assert_difference("PeriodicSlot.count") do
      post periodic_slots_url, params: { periodic_slot: { periodic_slot_blueprint_id: @periodic_slot.periodic_slot_blueprint_id, slot_id: @periodic_slot.slot_id } }, as: :json
    end

    assert_response :created
  end

  test "should show periodic_slot" do
    get periodic_slot_url(@periodic_slot), as: :json
    assert_response :success
  end

  test "should update periodic_slot" do
    patch periodic_slot_url(@periodic_slot), params: { periodic_slot: { periodic_slot_blueprint_id: @periodic_slot.periodic_slot_blueprint_id, slot_id: @periodic_slot.slot_id } }, as: :json
    assert_response :success
  end

  test "should destroy periodic_slot" do
    assert_difference("PeriodicSlot.count", -1) do
      delete periodic_slot_url(@periodic_slot), as: :json
    end

    assert_response :no_content
  end
end
