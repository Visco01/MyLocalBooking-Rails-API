require "test_helper"

class PeriodicSlotBlueprintsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @periodic_slot_blueprint = periodic_slot_blueprints(:one)
  end

  test "should get index" do
    get periodic_slot_blueprints_url, as: :json
    assert_response :success
  end

  test "should create periodic_slot_blueprint" do
    assert_difference("PeriodicSlotBlueprint.count") do
      post periodic_slot_blueprints_url, params: { periodic_slot_blueprint: { fromtime: @periodic_slot_blueprint.fromtime, slot_blueprint_id: @periodic_slot_blueprint.slot_blueprint_id, totime: @periodic_slot_blueprint.totime } }, as: :json
    end

    assert_response :created
  end

  test "should show periodic_slot_blueprint" do
    get periodic_slot_blueprint_url(@periodic_slot_blueprint), as: :json
    assert_response :success
  end

  test "should update periodic_slot_blueprint" do
    patch periodic_slot_blueprint_url(@periodic_slot_blueprint), params: { periodic_slot_blueprint: { fromtime: @periodic_slot_blueprint.fromtime, slot_blueprint_id: @periodic_slot_blueprint.slot_blueprint_id, totime: @periodic_slot_blueprint.totime } }, as: :json
    assert_response :success
  end

  test "should destroy periodic_slot_blueprint" do
    assert_difference("PeriodicSlotBlueprint.count", -1) do
      delete periodic_slot_blueprint_url(@periodic_slot_blueprint), as: :json
    end

    assert_response :no_content
  end
end
