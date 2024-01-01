# frozen_string_literal: true

require File.expand_path('../../test_helper', __dir__)

class WebhookEventTest < Test::Unit::TestCase
  def setup
    CashAppPay.api_base = CashAppPay::TestData::API::API_BASE
    CashAppPay.client_id = CashAppPay::TestData::API::CLIENT_ID
    CashAppPay.region = CashAppPay::TestData::API::REGION
    CashAppPay.signature = CashAppPay::TestData::API::SIGNATURE
    CashAppPay.api_key = CashAppPay::TestData::API::API_KEY
  end

  def test_list
    stub_request(:get, 'https://sandbox.api.cash.app/management/v1/webhook-events?limit=5')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::WebhookEvent.make_api_key_list.to_json)
    api_keys = CashAppPay::WebhookEvent.list({ limit: 5 })
    assert_equal(Hash[:limit, 5], api_keys.filters)
    assert_equal 'customer.created', api_keys.data[0].event_type
    assert_equal 'Cgl0dmNqa3R4MHk=', api_keys.cursor
  end
end
