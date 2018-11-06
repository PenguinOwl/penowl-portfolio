require "application_system_test_case"

class UserFlagsTest < ApplicationSystemTestCase
  setup do
    @user_flag = user_flags(:one)
  end

  test "visiting the index" do
    visit user_flags_url
    assert_selector "h1", text: "User Flags"
  end

  test "creating a User flag" do
    visit user_flags_url
    click_on "New User Flag"

    fill_in "Content", with: @user_flag.content
    fill_in "User", with: @user_flag.user
    click_on "Create User flag"

    assert_text "User flag was successfully created"
    click_on "Back"
  end

  test "updating a User flag" do
    visit user_flags_url
    click_on "Edit", match: :first

    fill_in "Content", with: @user_flag.content
    fill_in "User", with: @user_flag.user
    click_on "Update User flag"

    assert_text "User flag was successfully updated"
    click_on "Back"
  end

  test "destroying a User flag" do
    visit user_flags_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User flag was successfully destroyed"
  end
end
