require "application_system_test_case"

class System::SessionsTest < ApplicationSystemTestCase
  test "sign in page" do
    visit new_session_url

    assert_title "Sign in"
    assert_selector "h1", text: "Notes"
    assert_field "Email address",
      type: "email",
      placeholder: "Enter your email address"
    assert_field "Password",
      type: "password",
      placeholder: "Enter your password"
    assert_button "Sign in"
  end

  test "sign in page with invalid credentials" do
    visit new_session_url

    assert_title "Sign in"
    fill_in "Email address", with: users(:one).email_address
    fill_in "Password", with: "wrong password"
    click_button "Sign in"

    assert_current_path new_session_path
    assert_text "Try another email address or password."
  end

  test "sign in page with valid credentials" do
    visit new_session_url

    assert_title "Sign in"
    fill_in "Email address", with: users(:one).email_address
    fill_in "Password", with: "password"
    click_button "Sign in"

    assert_current_path root_path
  end
end
