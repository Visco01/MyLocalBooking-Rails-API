require "test_helper"

class SlotBlueprintsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @slot_blueprint = slot_blueprints(:one)
  end

  test "should get index" do
    get slot_blueprints_url, as: :json
    assert_response :success
  end

  test "should create slot_blueprint" do
    assert_difference("SlotBlueprint.count") do
      post slot_blueprints_url, params: { slot_blueprint: { establishment_id: @slot_blueprint.establishment_id, fromdate: @slot_blueprint.fromdate, reservationlimit: @slot_blueprint.reservationlimit, todate: @slot_blueprint.todate, weekdays: @slot_blueprint.weekdays } }, as: :json
    end

    assert_response :created
  end

  test "should show slot_blueprint" do
    get slot_blueprint_url(@slot_blueprint), as: :json
    assert_response :success
  end

  test "should update slot_blueprint" do
    patch slot_blueprint_url(@slot_blueprint), params: { slot_blueprint: { establishment_id: @slot_blueprint.establishment_id, fromdate: @slot_blueprint.fromdate, reservationlimit: @slot_blueprint.reservationlimit, todate: @slot_blueprint.todate, weekdays: @slot_blueprint.weekdays } }, as: :json
    assert_response :success
  end

  test "should destroy slot_blueprint" do
    assert_difference("SlotBlueprint.count", -1) do
      delete slot_blueprint_url(@slot_blueprint), as: :json
    end

    assert_response :no_content
  end
end
