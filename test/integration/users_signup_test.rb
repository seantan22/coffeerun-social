require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
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
  
  test "valid signup information" do
    
    get signup_path
    
    # Ensure new user is not created if submitted information is invalid
    assert_difference 'User.count', 1 do
      post users_path, params: { user: {  name: "Example User",
                                        email: "user@example.com",
                                        password: "abc123",
                                        password_confirmation: "abc123" } }
    end
    
    follow_redirect!
  
    # Ensure failed submission re-renders the new action
    assert_template 'users/show'
    assert_not flash.empty?
    
  end
  
end