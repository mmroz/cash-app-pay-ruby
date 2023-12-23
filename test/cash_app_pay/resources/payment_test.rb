# frozen_string_literal: true

require File.expand_path('../../test_helper', __dir__)

class PaymentTest < Test::Unit::TestCase
  API_BASE = 'sandbox.api.cash.app'
  CLIENT_ID = 'test_client_id'
  REGION = 'test_region'
  SIGNATURE = 'test_signature'
  API_KEY = 'test_api_key'

  OPTS_API_BASE = 'sandbox2.api.cash.app'
  OPTS_CLIENT_ID = 'opts_test_client_id'
  OPTS_REGION = 'opts_test_region'
  OPTS_SIGNATURE = 'opts_test_signature'
  OPTS_API_KEY = 'opts_test_api_key'

  def setup
    CashAppPay.api_base = API_BASE
    CashAppPay.client_id = CLIENT_ID
    CashAppPay.region = REGION
    CashAppPay.signature = SIGNATURE
    CashAppPay.api_key = API_KEY
  end

  def test_that_refresh_queries_endpoint
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/payments/PWC_1')
      .with(
        headers: expected_response_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData.make_payment.to_json, headers: {})
    payment = CashAppPay::Payment.new(id: 'PWC_1')
    payment.refresh
    assert_equal 'PWC_b1qk4mykgq3nbrdt2k4fpq3r8', payment.id
  end

  def test_that_refresh_uses_resource_opts
    stub_request(:get, 'https://sandbox2.api.cash.app/network/v1/payments/PWC_1')
      .with(
        headers: expected_response_headers(OPTS_CLIENT_ID, OPTS_API_KEY, OPTS_REGION, OPTS_SIGNATURE)
      )
      .to_return(status: 200, body: CashAppPay::TestData.make_payment.to_json, headers: {})
    payment = CashAppPay::Payment.new({ id: 'PWC_1' }, {
                                        api_base: OPTS_API_BASE,
                                        client_id: OPTS_CLIENT_ID,
                                        region: OPTS_REGION,
                                        signature: OPTS_SIGNATURE,
                                        api_key: OPTS_API_KEY
                                      })
    payment.refresh
    assert_equal 'PWC_b1qk4mykgq3nbrdt2k4fpq3r8', payment.id
    assert_equal({
                   api_base: 'sandbox2.api.cash.app',
                   api_key: 'opts_test_api_key',
                   client_id: 'opts_test_client_id',
                   region: 'opts_test_region',
                   signature: 'opts_test_signature'
                 }, payment.opts)
  end

  def test_that_retrieve_queries_endpoint
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/payments/PWC_1')
      .with(
        headers: expected_response_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData.make_payment.to_json, headers: {})
    payment = CashAppPay::Payment.retrieve('PWC_1')
    assert_equal 'PWC_b1qk4mykgq3nbrdt2k4fpq3r8', payment.id
  end

  def test_that_retrieve_with_opts_queries_endpoint_with_opts
    stub_request(:get, 'https://sandbox2.api.cash.app/network/v1/payments/PWC_1')
      .with(
        headers: expected_response_headers(OPTS_CLIENT_ID, OPTS_API_KEY, OPTS_REGION, OPTS_SIGNATURE)
      )
      .to_return(status: 200, body: CashAppPay::TestData.make_payment.to_json, headers: {})
    payment = CashAppPay::Payment.retrieve('PWC_1', {
                                             api_base: OPTS_API_BASE,
                                             client_id: OPTS_CLIENT_ID,
                                             region: OPTS_REGION,
                                             signature: OPTS_SIGNATURE,
                                             api_key: OPTS_API_KEY
                                           })
    assert_equal 'PWC_b1qk4mykgq3nbrdt2k4fpq3r8', payment.id
    assert_equal({
                   api_base: 'sandbox2.api.cash.app',
                   api_key: 'opts_test_api_key',
                   client_id: 'opts_test_client_id',
                   region: 'opts_test_region',
                   signature: 'opts_test_signature'
                 }, payment.opts)
  end

  def test_that_create_queries_endpoint
    CashAppPay::Utils.expects(:idempotency_key).returns(CashAppPay::TestData.idempotency_key)
    stub_request(:post, 'https://sandbox.api.cash.app/network/v1/payments')
      .with(
        body: CashAppPay::TestData.make_payment_create_params_json,
        headers: expected_response_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData.make_payment.to_json, headers: {})
    payment = CashAppPay::Payment.create(CashAppPay::TestData.make_payment_create_params)
    assert_equal 'PWC_b1qk4mykgq3nbrdt2k4fpq3r8', payment.id
  end

  def test_that_create_queries_endpoint_with_opts
    CashAppPay::Utils.expects(:idempotency_key).returns(CashAppPay::TestData.idempotency_key)
    stub_request(:post, 'https://sandbox2.api.cash.app/network/v1/payments')
      .with(
        body: CashAppPay::TestData.make_payment_create_params_json,
        headers: expected_response_headers(OPTS_CLIENT_ID, OPTS_API_KEY, OPTS_REGION, OPTS_SIGNATURE)
      )
      .to_return(status: 200, body: CashAppPay::TestData.make_payment.to_json, headers: {})
    payment = CashAppPay::Payment.create(CashAppPay::TestData.make_payment_create_params, {
                                           api_base: OPTS_API_BASE,
                                           client_id: OPTS_CLIENT_ID,
                                           region: OPTS_REGION,
                                           signature: OPTS_SIGNATURE,
                                           api_key: OPTS_API_KEY
                                         })
    assert_equal 'PWC_b1qk4mykgq3nbrdt2k4fpq3r8', payment.id
    assert_equal({
                   api_base: 'sandbox2.api.cash.app',
                   api_key: 'opts_test_api_key',
                   client_id: 'opts_test_client_id',
                   region: 'opts_test_region',
                   signature: 'opts_test_signature'
                 }, payment.opts)
  end

  def test_that_capture_queries_endpoint; end

  def test_that_capture_queries_endpoint_with_opts; end

  def test_that_capture_payment_using_static_method_queries_endpoint; end

  def test_that_capture_payment_using_static_method_queries_endpoint_with_opts; end

  def test_that_capture_payment_id_using_static_method_queries_endpoint; end

  def test_that_capture_payment_id_using_static_method_queries_endpoint_with_opts; end

  def test_that_payment_is_voided_by_idempotency_key; end

  def test_that_payment_is_voided_by_idempotency_key_with_opts; end

  private

  def expected_response_headers(client_id = CLIENT_ID, api_key = API_KEY, region = REGION, signature = SIGNATURE)
    {
      "Authorization": "Client #{client_id} #{api_key}",
      "X-Region": region,
      "X-Signature": signature,
      "Accept": 'application/json',
      "Content-Type": 'application/json'
    }
  end
end
