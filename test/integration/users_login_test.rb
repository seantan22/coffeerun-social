require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  # Get test data from users.yml fixture
  def setup
    @user = users(:person_test_data)
  end
  
  test "login with valid information followed by logout" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    assert_redirected_to root_url
    # assert_template 'users/show'
    # assert_select "a[href=?]", login_path, count: 0
    # assert_select "a[href=?]", logout_path
    # assert_select "a[href=?]", user_path(@user)
    # delete logout_path
    # assert_not is_logged_in?
    # assert_redirected_to root_url
    # # Simulate a user logging out in another window
    # delete logout_path
    # follow_redirect!
    # assert_select "a[href=?]", login_path
    # assert_select "a[href=?]", logout_path, count: 0
    # assert_select "a[href=?]", user_path(@user), count: 0
  end
  
  test "login with valid email / invalid password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email, password: 'invalid' } }
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  test "login with invalid information" do
    # Visit login path
    get login_path
    # Verify that the new sessions form renders properly.
    assert_template 'sessions/new'
    # Post to the sessions path with an invalid params hash
    post login_path, params: { session: { email: "", password: "" } }
    # Verify that the new sessions form gets re-rendered and a flash message appears
    assert_template 'sessions/new'
    assert_not flash.empty?
    # Visit another page (Home page)
    get root_path
    # Verify that the flash message does not appear
    assert flash.empty?
  end
  
  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies[:remember_token]
  end

  test "login without remembering" do
    # Login and set the cookie
    log_in_as(@user, remember_me: '1')
    # Login again and verify that the cookie is deleted
    log_in_as(@user, remember_me: '0')
    assert_empty cookies[:remember_token]
  end
  
end