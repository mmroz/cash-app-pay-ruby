# frozen_string_literal: true

require File.expand_path('../../test_helper', __dir__)

class CustomerRequestTest < Test::Unit::TestCase
  def setup
    CashAppPay.api_base = 'sandbox.api.cash.app'
    CashAppPay.client_id = 'test_client_id'
  end

  def test_that_refresh_queries_endpoint
    stub_request(:get, 'https://sandbox.api.cash.app/customer-request/v1/requests/GRR_1')
      .with(
        headers: CashAppPay::TestData.make_response_headers('test_client_id')
      )
      .to_return(status: 200, body: CashAppPay::TestData.make_pending_customer_request.to_json, headers: {})
    cr = CashAppPay::CustomerRequest.new(id: 'GRR_1')
    cr.refresh
    assert_equal 'PENDING', cr.status
  end

  def test_that_refresh_uses_resource_opts
    stub_request(:get, 'https://sandbox2.api.cash.app/customer-request/v1/requests/GRR_1')
      .with(
        headers: CashAppPay::TestData.make_response_headers('client_id_test')
      )
      .to_return(status: 200, body: CashAppPay::TestData.make_pending_customer_request.to_json, headers: {})
    cr = CashAppPay::CustomerRequest.new({ id: 'GRR_1' },
                                         { api_base: 'sandbox2.api.cash.app', client_id: 'client_id_test' })
    cr.refresh
    assert_equal 'PENDING', cr.status
    assert_equal({ api_base: 'sandbox2.api.cash.app', client_id: 'client_id_test' }, cr.opts)
  end

  def test_that_retrieve_queries_endpoint
    stub_request(:get, 'https://sandbox.api.cash.app/customer-request/v1/requests/GRR_1')
      .with(
        headers: CashAppPay::TestData.make_response_headers('test_client_id')
      )
      .to_return(status: 200, body: CashAppPay::TestData.make_pending_customer_request.to_json, headers: {})
    cr = CashAppPay::CustomerRequest.retrieve('GRR_1')
    assert_equal 'PENDING', cr.status
  end

  def test_that_retrieve_with_opts_queries_endpoint_with_opts
    stub_request(:get, 'https://sandbox2.api.cash.app/customer-request/v1/requests/GRR_1')
      .with(
        headers: CashAppPay::TestData.make_response_headers('client_id_test')
      )
      .to_return(status: 200, body: CashAppPay::TestData.make_pending_customer_request.to_json, headers: {})
    cr = CashAppPay::CustomerRequest.retrieve('GRR_1',
                                              { api_base: 'sandbox2.api.cash.app', client_id: 'client_id_test' })
    assert_equal 'PENDING', cr.status
    assert_equal({ api_base: 'sandbox2.api.cash.app', client_id: 'client_id_test' }, cr.opts)
  end

  def test_that_create_queries_endpoint
    CashAppPay::Utils.expects(:idempotency_key).returns(CashAppPay::TestData.idempotency_key)
    stub_request(:post, 'https://sandbox.api.cash.app/customer-request/v1/requests')
      .with(
        body: CashAppPay::TestData.make_customer_request_create_params_json,
        headers: CashAppPay::TestData.make_response_headers('test_client_id')
      )
      .to_return(status: 200, body: CashAppPay::TestData.make_pending_customer_request.to_json, headers: {})
    cr = CashAppPay::CustomerRequest.create(CashAppPay::TestData.make_customer_request_create_params)
    assert_equal 'PENDING', cr.status
  end

  def test_that_create_queries_endpoint_with_opts
    CashAppPay::Utils.expects(:idempotency_key).returns(CashAppPay::TestData.idempotency_key)
    stub_request(:post, 'https://sandbox2.api.cash.app/customer-request/v1/requests')
      .with(
        body: CashAppPay::TestData.make_customer_request_create_params_json,
        headers: CashAppPay::TestData.make_response_headers('client_id_test')
      )
      .to_return(status: 200, body: CashAppPay::TestData.make_pending_customer_request.to_json, headers: {})
    cr = CashAppPay::CustomerRequest.create(CashAppPay::TestData.make_customer_request_create_params,
                                            { api_base: 'sandbox2.api.cash.app', client_id: 'client_id_test' })
    assert_equal 'PENDING', cr.status
    assert_equal({ api_base: 'sandbox2.api.cash.app', client_id: 'client_id_test' }, cr.opts)
  end

  def test_that_save_queries_endpoint
    CashAppPay::Utils.expects(:idempotency_key).returns(CashAppPay::TestData.idempotency_key)
    stub_request(:post, 'https://sandbox.api.cash.app/customer-request/v1/requests')
      .with(
        body: CashAppPay::TestData.make_customer_request_create_params_json,
        headers: CashAppPay::TestData.make_response_headers('test_client_id')
      )
      .to_return(status: 200, body: CashAppPay::TestData.make_pending_customer_request.to_json, headers: {})
    cr = CashAppPay::CustomerRequest.new(CashAppPay::TestData.make_customer_request_create_params)
    assert cr.save
    assert_equal 'PENDING', cr.status
  end

  def test_that_save_queries_endpoint_with_opts
    CashAppPay::Utils.expects(:idempotency_key).returns(CashAppPay::TestData.idempotency_key)
    stub_request(:post, 'https://sandbox2.api.cash.app/customer-request/v1/requests')
      .with(
        body: CashAppPay::TestData.make_customer_request_create_params_json,
        headers: CashAppPay::TestData.make_response_headers('client_id_test')
      )
      .to_return(status: 200, body: CashAppPay::TestData.make_pending_customer_request.to_json, headers: {})
    cr = CashAppPay::CustomerRequest.new(CashAppPay::TestData.make_customer_request_create_params)
    assert cr.save({ api_base: 'sandbox2.api.cash.app', client_id: 'client_id_test' })
    assert_equal 'PENDING', cr.status
    assert_equal({ api_base: 'sandbox2.api.cash.app', client_id: 'client_id_test' }, cr.opts)
  end

  def test_that_update_queries_endpoint
    stub_request(:patch, 'https://sandbox.api.cash.app/customer-request/v1/requests/GRR_1')
      .with(
        body: CashAppPay::TestData.make_customer_request_update_params_json,
        headers: CashAppPay::TestData.make_response_headers('test_client_id')
      )
      .to_return(status: 200, body: CashAppPay::TestData.make_pending_customer_request.to_json, headers: {})
    cr = CashAppPay::CustomerRequest.new({ id: 'GRR_1' })
    assert cr.update(CashAppPay::TestData.make_customer_request_update_params)
    assert_equal 'PENDING', cr.status
  end

  def test_that_update_queries_endpoint_with_opts
    stub_request(:patch, 'https://sandbox2.api.cash.app/customer-request/v1/requests/GRR_1')
      .with(
        body: CashAppPay::TestData.make_customer_request_update_params_json,
        headers: CashAppPay::TestData.make_response_headers('client_id_test')
      )
      .to_return(status: 200, body: CashAppPay::TestData.make_pending_customer_request.to_json, headers: {})
    cr = CashAppPay::CustomerRequest.new({ id: 'GRR_1' })
    assert cr.update(CashAppPay::TestData.make_customer_request_update_params, { api_base: 'sandbox2.api.cash.app', client_id: 'client_id_test' })
    assert_equal 'PENDING', cr.status
    assert_equal({ api_base: 'sandbox2.api.cash.app', client_id: 'client_id_test' }, cr.opts)
  end
end
