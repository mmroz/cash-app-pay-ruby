# frozen_string_literal: true

require File.expand_path('../../test_helper', __dir__)

class CustomerTest < Test::Unit::TestCase
  def setup
    CashAppPay.api_base = CashAppPay::TestData::API::API_BASE
    CashAppPay.client_id = CashAppPay::TestData::API::CLIENT_ID
    CashAppPay.region = CashAppPay::TestData::API::REGION
    CashAppPay.signature = CashAppPay::TestData::API::SIGNATURE
    CashAppPay.api_key = CashAppPay::TestData::API::API_KEY
  end

  def test_refresh
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/customers/cust_1')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Customer.make_customer.to_json)
    customer = CashAppPay::Customer.new(id: 'cust_1')
    customer.refresh
    assert_equal 'string', customer.cashtag
  end

  def test_retrieve
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/customers/cust_1')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Customer.make_customer.to_json)
    customer = CashAppPay::Customer.retrieve(id: 'cust_1')
    assert_equal 'string', customer.cashtag
  end

  def test_list
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/customers?limit=5')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Customer.make_customer_list.to_json)
    customers = CashAppPay::Customer.list({ limit: 5 })
    assert_equal(Hash[:limit, 5], customers.filters)
    assert_equal 'string', customers.data[0].cashtag
    assert_equal 'Cgl0dmNqa3R4MHk=', customers.cursor
  end

  def test_retrieve_grant
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/customers/cust_1/grants/GRG_1')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Grant.make_grant.to_json)
    customer = CashAppPay::Customer.new(id: 'cust_1')
    grant = customer.retrieve_grant('GRG_1')
    assert_equal 'GRR_1hrxhz136krcq6ezdte2ha5q', grant.request_id

    other_grant = CashAppPay::Grant.new(id: 'GRG_1')
    other_grant = CashAppPay::Customer.retrieve_grant(customer, other_grant)
    assert_equal 'GRR_1hrxhz136krcq6ezdte2ha5q', other_grant.request_id
  end

  def test_revoke_grant
    stub_request(:post, 'https://sandbox.api.cash.app/network/v1/customers/cust_1/grants/GRG_1/revoke')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Grant.make_grant.to_json)
    customer = CashAppPay::Customer.new(id: 'cust_1')
    grant = customer.revoke_grant('GRG_1')
    assert_equal 'GRR_1hrxhz136krcq6ezdte2ha5q', grant.request_id

    other_grant = CashAppPay::Grant.new(id: 'GRG_1')
    other_grant = CashAppPay::Customer.revoke_grant(customer, other_grant)
    assert_equal 'GRR_1hrxhz136krcq6ezdte2ha5q', other_grant.request_id
  end
end
