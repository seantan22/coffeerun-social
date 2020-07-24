require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  
  def setup
    @user = users(:person_test_data)
    log_in_as @user
  end
  
  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_match @user.orders.count.to_s, response.body
    # assert_select 'div.pagination'
    # @user.orders.paginate(page: 1, per_page: 10).each do |order|
    #   assert_match order.item, response.body
    #   assert_match order.details, response.body
    #   assert_match order.vendor, response.body
    #   assert_match order.zone, response.body
    #   assert_match order.size, response.body
    # end
  end
  
end
