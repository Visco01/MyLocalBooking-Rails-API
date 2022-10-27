require "test_helper"

class ManualSlotBlueprintsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manual_slot_blueprint = manual_slot_blueprints(:one)
  end

  test "should get index" do
    get manual_slot_blueprints_url, as: :json
    assert_response :success
  end

  test "should create manual_slot_blueprint" do
    assert_difference("ManualSlotBlueprint.count") do
      post manual_slot_blueprints_url, params: { manual_slot_blueprint: { closetime: @manual_slot_blueprint.closetime, opentime: @manual_slot_blueprint.opentime, slot_blueprint_id: @manual_slot_blueprint.slot_blueprint_id } }, as: :json
    end

    assert_response :created
  end

  test "should show manual_slot_blueprint" do
    get manual_slot_blueprint_url(@manual_slot_blueprint), as: :json
    assert_response :success
  end

  test "should update manual_slot_blueprint" do
    patch manual_slot_blueprint_url(@manual_slot_blueprint), params: { manual_slot_blueprint: { closetime: @manual_slot_blueprint.closetime, opentime: @manual_slot_blueprint.opentime, slot_blueprint_id: @manual_slot_blueprint.slot_blueprint_id } }, as: :json
    assert_response :success
  end

  test "should destroy manual_slot_blueprint" do
    assert_difference("ManualSlotBlueprint.count", -1) do
      delete manual_slot_blueprint_url(@manual_slot_blueprint), as: :json
    end

    assert_response :no_content
  end
end
