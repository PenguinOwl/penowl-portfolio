require 'test_helper'

class UserFlagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_flag = user_flags(:one)
  end

  test "should get index" do
    get user_flags_url
    assert_response :success
  end

  test "should get new" do
    get new_user_flag_url
    assert_response :success
  end

  test "should create user_flag" do
    assert_difference('UserFlag.count') do
      post user_flags_url, params: { user_flag: { content: @user_flag.content, user: @user_flag.user } }
    end

    assert_redirected_to user_flag_url(UserFlag.last)
  end

  test "should show user_flag" do
    get user_flag_url(@user_flag)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_flag_url(@user_flag)
    assert_response :success
  end

  test "should update user_flag" do
    patch user_flag_url(@user_flag), params: { user_flag: { content: @user_flag.content, user: @user_flag.user } }
    assert_redirected_to user_flag_url(@user_flag)
  end

  test "should destroy user_flag" do
    assert_difference('UserFlag.count', -1) do
      delete user_flag_url(@user_flag)
    end

    assert_redirected_to user_flags_url
  end
end
