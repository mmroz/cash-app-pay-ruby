# frozen_string_literal: true

require File.expand_path('../../test_helper', __dir__)

class CustomerRequestTest < Test::Unit::TestCase
  def setup
    CashAppPay.api_base = CashAppPay::TestData::API::API_BASE
    CashAppPay.client_id = CashAppPay::TestData::API::CLIENT_ID
  end

  def test_refresh
    stub_request(:get, 'https://sandbox.api.cash.app/customer-request/v1/requests/GRR_1')
      .with(
        headers: CashAppPay::TestData::API.customer_request_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::CustomerRequest.make_customer_request.to_json)
    customer_request = CashAppPay::CustomerRequest.new(id: 'GRR_1')
    customer_request.refresh
    assert_equal 'PENDING', customer_request.status
  end

  def test_retrieve
    stub_request(:get, 'https://sandbox.api.cash.app/customer-request/v1/requests/GRR_1')
      .with(
        headers: CashAppPay::TestData::API.customer_request_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::CustomerRequest.make_customer_request.to_json)
    customer_request = CashAppPay::CustomerRequest.retrieve(id: 'GRR_1')
    assert_equal 'PENDING', customer_request.status
  end

  def test_create
    params = CashAppPay::TestData::CustomerRequest.make_params
    stub_request(:post, 'https://sandbox.api.cash.app/customer-request/v1/requests')
      .with(
        body: Hash[:request, params, :idempotency_key, 'idempotency'].to_json,
        headers: CashAppPay::TestData::API.customer_request_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::CustomerRequest.make_customer_request.to_json)
    params_with_idempotency = params.merge(idempotency_key: 'idempotency')
    customer_request = CashAppPay::CustomerRequest.create(params_with_idempotency)
    assert_equal 'PENDING', customer_request.status
  end

  def test_update
    stub_request(:patch, 'https://sandbox.api.cash.app/customer-request/v1/requests/GRR_1')
      .with(
        body: Hash[:request, CashAppPay::TestData::CustomerRequest.make_params].to_json,
        headers: CashAppPay::TestData::API.customer_request_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::CustomerRequest.make_customer_request.to_json)
    customer_request = CashAppPay::CustomerRequest.update('GRR_1', CashAppPay::TestData::CustomerRequest.make_params)
    assert_equal 'PENDING', customer_request.status
  end
end
