# frozen_string_literal: true

require File.expand_path('../../test_helper', __dir__)

class PaymentTest < Test::Unit::TestCase
  def setup
    CashAppPay.api_base = CashAppPay::TestData::API::API_BASE
    CashAppPay.client_id = CashAppPay::TestData::API::CLIENT_ID
    CashAppPay.region = CashAppPay::TestData::API::REGION
    CashAppPay.signature = CashAppPay::TestData::API::SIGNATURE
    CashAppPay.api_key = CashAppPay::TestData::API::API_KEY
  end

  def test_refresh
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/payments/PWC_1')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Payment.make_payment.to_json)
    payment = CashAppPay::Payment.new(id: 'PWC_1')
    payment.refresh
    assert_equal 'AUTHORIZED', payment.status
  end

  def test_retrieve
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/payments/PWC_1')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Payment.make_payment.to_json)
    payment = CashAppPay::Payment.retrieve(id: 'PWC_1')
    assert_equal 'AUTHORIZED', payment.status
  end

  def test_list
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/payments?limit=5')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Payment.make_payment_list.to_json)
    payments = CashAppPay::Payment.list({ limit: 5 })
    assert_equal(Hash[:limit, 5], payments.filters)
    assert_equal 'AUTHORIZED', payments.data[0].status
    assert_equal 'Cgl0dmNqa3R4MHk=', payments.cursor
  end

  def test_create
    params = CashAppPay::TestData::Payment.make_params
    stub_request(:post, 'https://sandbox.api.cash.app/network/v1/payments')
      .with(
        body: Hash[:payment, params, :idempotency_key, 'idempotency'].to_json,
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Payment.make_payment.to_json)
    params_with_idempotency = params.merge(idempotency_key: 'idempotency')
    payment = CashAppPay::Payment.create(params_with_idempotency)
    assert_equal 'AUTHORIZED', payment.status
  end

  def test_capture
    stub_request(:post, 'https://sandbox.api.cash.app/network/v1/payments/PWC_1/capture')
      .with(
        body: { idempotency_key: 'idempotency' }.to_json,
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Payment.make_payment.to_json)
    payment = CashAppPay::Payment.new(id: 'PWC_1')
    captured_payment = CashAppPay::Payment.capture(payment, { idempotency_key: 'idempotency' })
    assert_equal 'AUTHORIZED', captured_payment.status

    captured_payment = CashAppPay::Payment.new(id: 'PWC_1').capture({ idempotency_key: 'idempotency' })
    assert_equal 'AUTHORIZED', captured_payment.status
  end

  def test_void
    stub_request(:post, 'https://sandbox.api.cash.app/network/v1/payments/PWC_1/void')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Payment.make_payment.to_json)
    payment = CashAppPay::Payment.new(id: 'PWC_1')
    voided_payment = CashAppPay::Payment.void(payment)
    assert_equal 'AUTHORIZED', voided_payment.status

    voided_payment = payment.void
    assert_equal 'AUTHORIZED', voided_payment.status
  end

  def test_void_by_idempotency_key
    stub_request(:post, 'https://sandbox.api.cash.app/network/v1/payments/void-by-idempotency-key')
      .with(
        body: { idempotency_key: 'idempotency' }.to_json,
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Payment.make_payment.to_json)
    CashAppPay::Payment.new(id: 'PWC_1')
    voided_payment = CashAppPay::Payment.void_by_idempotency_key({ idempotency_key: 'idempotency' })
    assert_equal 'AUTHORIZED', voided_payment.status
  end
end
