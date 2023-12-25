# frozen_string_literal: true

require File.expand_path('../../test_helper', __dir__)

class FeePlanTest < Test::Unit::TestCase
  def setup
    CashAppPay.api_base = CashAppPay::TestData::API::API_BASE
    CashAppPay.client_id = CashAppPay::TestData::API::CLIENT_ID
    CashAppPay.region = CashAppPay::TestData::API::REGION
    CashAppPay.signature = CashAppPay::TestData::API::SIGNATURE
    CashAppPay.api_key = CashAppPay::TestData::API::API_KEY
  end

  def test_refresh
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/fee-plans/fee_1')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::FeePlan.make_fee_plan.to_json)
    fee_plan = CashAppPay::FeePlan.new(id: 'fee_1')
    fee_plan.refresh
    assert_equal 'ACTIVE', fee_plan.status
  end

  def test_retrieve
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/fee-plans/fee_1')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::FeePlan.make_fee_plan.to_json)
    fee_plan = CashAppPay::FeePlan.retrieve(id: 'fee_1')
    assert_equal 'ACTIVE', fee_plan.status
  end

  def test_list
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/fee-plans?limit=5')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::FeePlan.make_fee_plan_list.to_json)
    fee_plans = CashAppPay::FeePlan.list({ limit: 5 })
    assert_equal(Hash[:limit, 5], fee_plans.filters)
    assert_equal 'FEE_kewjsmjt35t8qhzyjeqcst5me', fee_plans.data[0].id
    assert_equal 'Cgl0dmNqa3R4MHk=', fee_plans.cursor
  end
end
