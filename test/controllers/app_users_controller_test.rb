require "test_helper"

class AppUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @app_user = app_users(:one)
  end

  test "should get index" do
    get app_users_url, as: :json
    assert_response :success
  end

  test "should create app_user" do
    assert_difference("AppUser.count") do
      post app_users_url, params: { app_user: { cellphone: @app_user.cellphone, dob: @app_user.dob, email: @app_user.email, firstname: @app_user.firstname, lastname: @app_user.lastname, password_digest: @app_user.password_digest } }, as: :json
    end

    assert_response :created
  end

  test "should show app_user" do
    get app_user_url(@app_user), as: :json
    assert_response :success
  end

  test "should update app_user" do
    patch app_user_url(@app_user), params: { app_user: { cellphone: @app_user.cellphone, dob: @app_user.dob, email: @app_user.email, firstname: @app_user.firstname, lastname: @app_user.lastname, password_digest: @app_user.password_digest } }, as: :json
    assert_response :success
  end

  test "should destroy app_user" do
    assert_difference("AppUser.count", -1) do
      delete app_user_url(@app_user), as: :json
    end

    assert_response :no_content
  end
end
