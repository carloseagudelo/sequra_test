require "test_helper"

class DisbursementsControllerTest < ActionDispatch::IntegrationTest

  ## Search test

  test "search endpoint with incorrect merchant_id" do
    post(disbursements_search_url, params: {merchant_id: 'XXX', from: DateTime.now, to: 'XXXX'})
    assert_response :bad_request
    assert_equal("merchant_id should be a valid value", JSON.parse(response.body)[0])
  end

  test "search endpoint with incorrect from" do
    post(disbursements_search_url, params: {merchant_id: merchants(:one).id, from: 'XXXX', to: DateTime.now})
    assert_response :bad_request
    assert_equal("Should be a date", JSON.parse(response.body)[0])
  end

  test "search endpoint with incorrect to" do
    post(disbursements_search_url, params: {merchant_id: merchants(:one).id, from: DateTime.now, to: 'XXXX'})
    assert_response :bad_request
    assert_equal("Should be a date", JSON.parse(response.body)[0])
  end

  test "search endpoint without params" do
    order = Order.create(merchant: Merchant.first, shopper: Shopper.first, amount: 150.9, completed_at: (DateTime.now - 4.days))
    order.disburse!
    post(disbursements_search_url, params: {})
    assert_response :ok
    assert_not_empty(response.body)
    JSON.parse(response.body)['data'].any?{|item| item["id"] == order.disbursement.id}.eql? true
  end

  test "search endpoint without from param" do
    merchant = merchants(:merchant_without_order)
    order = Order.create(merchant: merchant, shopper: Shopper.first, amount: 150.9, completed_at: (DateTime.now - 3.days))
    order.disburse!
    post(disbursements_search_url, params: {merchant_id: merchant.id, to: (DateTime.now - 1.days)})
    assert_response :ok
    assert_not_empty(response.body)
    JSON.parse(response.body)['data'].any?{|item| item["id"] == order.disbursement.id}.eql? true
  end

  test "search endpoint without to param" do
    merchant = merchants(:merchant_without_order)
    order = Order.create(merchant: merchant, shopper: Shopper.first, amount: 150.9, completed_at: (DateTime.now - 3.days))
    order.disburse!
    post(disbursements_search_url, params: {merchant_id: merchant.id, from: (DateTime.now - 10.days)})
    assert_response :ok
    assert_not_empty(response.body)
    JSON.parse(response.body)['data'].any?{|item| item["id"] == order.disbursement.id}.eql? true
  end

  test "search endpoint without merchant_id param" do
    post(disbursements_search_url, params: {from: (DateTime.now - 100.days), to: DateTime.now})
    assert_response :ok
    assert_not_empty(response.body)
  end

  test "search endpoint without complete params" do
    merchant = merchants(:merchant_without_order)
    order = Order.create(merchant: merchant, shopper: Shopper.first, amount: 150.9, completed_at: (DateTime.now - 3.days))
    order.disburse!
    post(disbursements_search_url, params: {merchant_id: merchant.id, from: (DateTime.now - 100.days), to: DateTime.now})
    assert_response :ok
    assert_not_empty(response.body)
    JSON.parse(response.body)['data'].any?{|item| item["id"] == order.disbursement.id}.eql? true
  end

  ## Massive test

  test "massive endpoint with incorrect merchant_id" do
    post(disbursements_massive_url, params: {merchant_id: 'XXX', from: DateTime.now, to: 'XXXX'})
    assert_response :bad_request
    assert_equal("merchant_id should be a valid value", JSON.parse(response.body)[0])
  end

  test "massive endpoint with incorrect from" do
    post(disbursements_massive_url, params: {merchant_id: merchants(:one).id, from: 'XXXX', to: DateTime.now})
    assert_response :bad_request
    assert_equal("Should be a date", JSON.parse(response.body)[0])
  end

  test "massive endpoint with incorrect to" do
    post(disbursements_massive_url, params: {merchant_id: merchants(:one).id, from: DateTime.now, to: 'XXXX'})
    assert_response :bad_request
    assert_equal("Should be a date", JSON.parse(response.body)[0])
  end

  test "massive endpoint without params" do
    post(disbursements_massive_url, params: {})
    assert_response :ok
  end

  test "massive endpoint without from param" do
    post(disbursements_massive_url, params: {merchant_id: merchants(:one).id, to: (DateTime.now - 1.days)})
    assert_response :ok
  end

  test "massive endpoint without to param" do
    post(disbursements_massive_url, params: {merchant_id: merchants(:one).id, from: (DateTime.now - 10.days)})
    assert_response :ok
  end

  test "massive endpoint without merchant_id param" do
    post(disbursements_massive_url, params: {from: (DateTime.now - 100.days), to: DateTime.now})
    assert_response :ok
  end

  test "massive endpoint without complete params" do
    post(disbursements_massive_url, params: {merchant_id: merchants(:one).id, from: (DateTime.now - 100.days), to: DateTime.now})
    assert_response :ok
  end

end
