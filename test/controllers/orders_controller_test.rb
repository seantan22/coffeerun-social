require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @order = orders(:order_a)
  end
  
  test "should redirect create when not logged in" do
    assert_no_difference 'Order.count' do
      post orders_path, params: { order: { item: "Coffee",
                                            details: "Extra Hot",
                                            vendor: "Tim Hortons",
                                            size: "Large",
                                            zone: "McLennan 6B" } }
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy when not logged in" do
    assert_no_difference "Order.count" do
      delete order_path(@order)  
    end
    assert_redirected_to login_url
  end
  
end
