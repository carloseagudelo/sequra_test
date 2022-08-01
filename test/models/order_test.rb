require "test_helper"

class OrderTest < ActiveSupport::TestCase
  test "should not save order without information" do
    order = Order.new()
    assert_not order.save, "no saved the order without information"
    assert_not_empty(order.errors.map{|error| error.attribute})
    assert_includes(order.errors.map{|error| error.attribute}, :merchant)
    assert_includes(order.errors.map{|error| error.attribute}, :shopper)
    assert_includes(order.errors.map{|error| error.attribute}, :amount)
  end
  
  test "should not save order without merchant" do
    order = Order.new(merchant: nil, shopper: Shopper.first, amount: nil, completed_at: nil)
    assert_not order.save, "no saved the order without merchant"
    assert_not_empty(order.errors.map{|error| error.attribute})
    assert_includes(order.errors.map{|error| error.attribute}, :merchant)
  end

  test "should not save order without shopper" do
    order = Order.new(merchant: Merchant.first, shopper: nil, amount: nil, completed_at: nil)
    assert_not order.save, "no saved the order without shopper"
    assert_not_empty(order.errors.map{|error| error.attribute})
    assert_includes(order.errors.map{|error| error.attribute}, :shopper)
  end

  test "should not save order without amount attribute" do
    order = Order.new(merchant: Merchant.first, shopper: Shopper.first, amount: nil, completed_at: nil)
    assert_not order.save, "no saved the order without amount"
    assert_not_empty(order.errors.map{|error| error.attribute})
    assert_includes(order.errors.map{|error| error.attribute}, :amount)
  end

  test "should not save order without completed_at attribute" do
    order = Order.new(merchant: Merchant.first, shopper: Shopper.first, amount: 50, completed_at: nil)
    assert order.save, "Saved the order without completed_at"
  end

  test "should save order with information" do
    order = Order.new(merchant: Merchant.first, shopper: Shopper.first, amount: 50.9, completed_at: DateTime.now)
    assert order.save, "Saved the order with complete information"
  end
end
