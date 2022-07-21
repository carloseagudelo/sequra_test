require "test_helper"

class DisbursementTest < ActiveSupport::TestCase
  test "should not save disbursement without information" do
    disbursement = Disbursement.new()
    assert_not disbursement.save, "No saved the disbursement without information"
    assert_not_empty(disbursement.errors.map{|error| error.attribute})
    assert_includes(disbursement.errors.map{|error| error.attribute}, :order)
    assert_includes(disbursement.errors.map{|error| error.attribute}, :amount)
    assert_includes(disbursement.errors.map{|error| error.attribute}, :percentage)
  end
  
  test "should not save disbursement without order" do
    disbursement = Disbursement.new(order: nil, amount: 0.91, percentage: 0.01)
    assert_not disbursement.save, "no saved the disbursement without order"
    assert_not_empty(disbursement.errors.map{|error| error.attribute})
    assert_includes(disbursement.errors.map{|error| error.attribute}, :order)
  end

  test "should not save disbursement without amount" do
    disbursement = Disbursement.new(order: orders(:without_disbursement), amount: nil, percentage: 0.01)
    assert_not disbursement.save, "no saved the disbursement without amount"
    assert_not_empty(disbursement.errors.map{|error| error.attribute})
    assert_includes(disbursement.errors.map{|error| error.attribute}, :amount)
  end

  test "should not save disbursement without percentage attribute" do
    disbursement = Disbursement.new(order: orders(:without_disbursement), amount: 0.91, percentage: nil)
    assert_not disbursement.save, "no saved the disbursement without percentage"
    assert_not_empty(disbursement.errors.map{|error| error.attribute})
    assert_includes(disbursement.errors.map{|error| error.attribute}, :percentage)
  end

  test "should not save disbursement with disbersed order" do
    disbursement = Disbursement.new(order: Order.first, amount: 0.91, percentage: 0.01)
    assert_not disbursement.save, "no saved the with disbursement yet"
    assert_not_empty(disbursement.errors.map{|error| error.attribute})
    assert_equal(disbursement.errors.first.message, "This order has been disbursed before")
  end

  test "should save disbursement with information" do
    disbursement = Disbursement.new(order: orders(:without_disbursement), amount: 0.91, percentage: 0.01)
    assert disbursement.save, "saved the disbursement with complete information"
  end
end
