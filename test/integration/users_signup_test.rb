require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  def setup
    ActionMailer::Base.deliveries.clear
  end
  
  test "invalid signup information" do
    get signup_path
    # Ensure new user is not created if submitted information is invalid
    assert_no_difference 'User.count' do
      post users_path, params: { user: {  name: "",
                                        email: "user@invalid",
                                        password: "abc123",
                                        password_confirmation: "123abc" } }
    end
    # Ensure failed submission re-renders the new action
    assert_template 'users/new'
    # Ensure error messages appear
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end
  
  test "valid signup information with account activation" do
    get signup_path
    # Ensure new user is not created if submitted information is invalid
    assert_difference 'User.count', 1 do
      post users_path, params: { user: {  name: "Example User",
                                          email: "user@example.com",
                                          password: "abc123",
                                          password_confirmation: "abc123" } }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    # Attempt to log in before activation
    log_in_as(user)
    assert_not is_logged_in?
    # Invalid token, valid email
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?
    # Valid token, invalid email
    get edit_account_activation_path(user.activation_token, email: "wrong")
    assert_not is_logged_in?
    # Valid token, valid email
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
  
end