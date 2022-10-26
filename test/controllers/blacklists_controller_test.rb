require "test_helper"

class BlacklistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blacklist = blacklists(:one)
  end

  test "should get index" do
    get blacklists_url, as: :json
    assert_response :success
  end

  test "should create blacklist" do
    assert_difference("Blacklist.count") do
      post blacklists_url, params: { blacklist: { providers_id: @blacklist.providers_id, usercellphone: @blacklist.usercellphone } }, as: :json
    end

    assert_response :created
  end

  test "should show blacklist" do
    get blacklist_url(@blacklist), as: :json
    assert_response :success
  end

  test "should update blacklist" do
    patch blacklist_url(@blacklist), params: { blacklist: { providers_id: @blacklist.providers_id, usercellphone: @blacklist.usercellphone } }, as: :json
    assert_response :success
  end

  test "should destroy blacklist" do
    assert_difference("Blacklist.count", -1) do
      delete blacklist_url(@blacklist), as: :json
    end

    assert_response :no_content
  end
end
