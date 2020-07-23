require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:person_test_data)
    @order = @user.orders.build( item: "Coffee", 
                        details: "Almond Milk",
                        vendor: "Tim Hortons",
                        size: "Large",
                        zone: "McLennan 6B",
                        user_id: @user.id )
  end
  
  test "should be valid" do
    assert @order.valid?
  end
  
  test "user id should be present" do
    @order.user_id = nil
    assert_not @order.valid?
  end
  
  test "item should be present" do
    @order.item = "  "
    assert_not @order.valid?
  end
  
  test "details should be present" do
    @order.details = "  "
    assert_not @order.valid?
  end
  
  test "details should be at most 80 characters" do
    @order.details = "a" * 81
    assert_not @order.valid?
  end
  
  test "vendor should be present" do
    @order.vendor = "  "
    assert_not @order.valid?
  end
  
  test "size should be present" do
    @order.size = "  "
    assert_not @order.valid?
  end
  
  test "zone should be present" do
    @order.zone = "  "
    assert_not @order.valid?
  end
  
  test "most recent order should be first" do
    assert_equal orders(:most_recent), Order.first
  end
  
end
