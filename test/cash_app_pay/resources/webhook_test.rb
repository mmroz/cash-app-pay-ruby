# frozen_string_literal: true

require File.expand_path('../../test_helper', __dir__)

class WebhookTest < Test::Unit::TestCase
  def setup
    CashAppPay.api_base = CashAppPay::TestData::API::API_BASE
    CashAppPay.client_id = CashAppPay::TestData::API::CLIENT_ID
    CashAppPay.region = CashAppPay::TestData::API::REGION
    CashAppPay.signature = CashAppPay::TestData::API::SIGNATURE
    CashAppPay.api_key = CashAppPay::TestData::API::API_KEY
  end

  def test_refresh
    stub_request(:get, 'https://sandbox.api.cash.app/management/v1/webhook-endpoints/WE_1')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Webhook.make_webhook_endpoint.to_json)
    webhook = CashAppPay::Webhook.new(id: 'WE_1')
    webhook.refresh
    assert_equal 'string', webhook.reference_id
  end

  def test_retrieve
    stub_request(:get, 'https://sandbox.api.cash.app/management/v1/webhook-endpoints/WE_1')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Webhook.make_webhook_endpoint.to_json)
    webhook = CashAppPay::Webhook.retrieve(id: 'WE_1')
    assert_equal 'string', webhook.reference_id
  end

  def test_list
    stub_request(:get, 'https://sandbox.api.cash.app/management/v1/webhook-endpoints?limit=5')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Webhook.make_webhook_endpoint_list.to_json)
    webhooks = CashAppPay::Webhook.list({ limit: 5 })
    assert_equal(Hash[:limit, 5], webhooks.filters)
    assert_equal 'string', webhooks.data[0].reference_id
    assert_equal 'Cgl0dmNqa3R4MHk=', webhooks.cursor
  end

  def test_create
    params = CashAppPay::TestData::Webhook.make_params
    stub_request(:post, 'https://sandbox.api.cash.app/management/v1/webhook-endpoints')
      .with(
        body: Hash[:webhook_endpoint, params, :idempotency_key, 'idempotency'].to_json,
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Webhook.make_webhook_endpoint.to_json)
    params_with_idempotency = params.merge(idempotency_key: 'idempotency')
    webhook = CashAppPay::Webhook.create(params_with_idempotency)
    assert_equal 'string', webhook.reference_id
  end
end
