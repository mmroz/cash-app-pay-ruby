# frozen_string_literal: true

require File.expand_path('../../test_helper', __dir__)

class RefundTest < Test::Unit::TestCase
  def setup
    CashAppPay.api_base = CashAppPay::TestData::API::API_BASE
    CashAppPay.client_id = CashAppPay::TestData::API::CLIENT_ID
    CashAppPay.region = CashAppPay::TestData::API::REGION
    CashAppPay.signature = CashAppPay::TestData::API::SIGNATURE
    CashAppPay.api_key = CashAppPay::TestData::API::API_KEY
  end

  def test_refresh
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/refunds/PWCR_1')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Refund.make_refund.to_json)
    refund = CashAppPay::Refund.new(id: 'PWCR_1')
    refund.refresh
    assert_equal 'AUTHORIZED', refund.status
  end

  def test_retrieve
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/refunds/PWCR_1')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Refund.make_refund.to_json)
    refund = CashAppPay::Refund.retrieve(id: 'PWCR_1')
    assert_equal 'AUTHORIZED', refund.status
  end

  def test_list
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/refunds?limit=5')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Refund.make_refund_list.to_json)
    refunds = CashAppPay::Refund.list({ limit: 5 })
    assert_equal(Hash[:limit, 5], refunds.filters)
    assert_equal 'AUTHORIZED', refunds.data[0].status
    assert_equal 'Cgl0dmNqa3R4MHk=', refunds.cursor
  end

  def test_create
    params = CashAppPay::TestData::Refund.make_params
    stub_request(:post, 'https://sandbox.api.cash.app/network/v1/refunds')
      .with(
        body: Hash[:refund, params, :idempotency_key, 'idempotency'].to_json,
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Refund.make_refund.to_json)
    params_with_idempotency = params.merge(idempotency_key: 'idempotency')
    refund = CashAppPay::Refund.create(params_with_idempotency)
    assert_equal 'AUTHORIZED', refund.status
  end

  def test_capture
    stub_request(:post, 'https://sandbox.api.cash.app/network/v1/refunds/PWCR_1/capture')
      .with(
        body: { idempotency_key: 'idempotency' }.to_json,
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Refund.make_refund.to_json)
    refund = CashAppPay::Refund.new(id: 'PWCR_1')
    captured_refund = CashAppPay::Refund.capture(refund, { idempotency_key: 'idempotency' })
    assert_equal 'AUTHORIZED', captured_refund.status

    captured_refund = CashAppPay::Refund.new(id: 'PWCR_1').capture({ idempotency_key: 'idempotency' })
    assert_equal 'AUTHORIZED', captured_refund.status
  end

  def test_void
    stub_request(:post, 'https://sandbox.api.cash.app/network/v1/refunds/PWCR_1/void')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Refund.make_refund.to_json)
    refund = CashAppPay::Refund.new(id: 'PWCR_1')
    voided_refund = CashAppPay::Refund.void(refund)
    assert_equal 'AUTHORIZED', voided_refund.status

    voided_refund = refund.void
    assert_equal 'AUTHORIZED', voided_refund.status
  end

  def test_void_by_idempotency_key
    stub_request(:post, 'https://sandbox.api.cash.app/network/v1/refunds/void-by-idempotency-key')
      .with(
        body: { idempotency_key: 'idempotency' }.to_json,
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Refund.make_refund.to_json)
    CashAppPay::Refund.new(id: 'PWCR_1')
    voided_refund = CashAppPay::Refund.void_by_idempotency_key({ idempotency_key: 'idempotency' })
    assert_equal 'AUTHORIZED', voided_refund.status
  end
end
