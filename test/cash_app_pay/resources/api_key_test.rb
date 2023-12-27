# frozen_string_literal: true

require File.expand_path('../../test_helper', __dir__)

class APIKeyTest < Test::Unit::TestCase
  def setup
    CashAppPay.api_base = CashAppPay::TestData::API::API_BASE
    CashAppPay.client_id = CashAppPay::TestData::API::CLIENT_ID
    CashAppPay.region = CashAppPay::TestData::API::REGION
    CashAppPay.signature = CashAppPay::TestData::API::SIGNATURE
    CashAppPay.api_key = CashAppPay::TestData::API::API_KEY
  end

  def test_refresh
    stub_request(:get, 'https://sandbox.api.cash.app/management/v1/api-keys/KEY_1')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::APIKey.make_api_key.to_json)
    api_key = CashAppPay::APIKey.new(id: 'KEY_1')
    api_key.refresh
    assert_equal 'string', api_key.reference_id
  end

  def test_retrieve
    stub_request(:get, 'https://sandbox.api.cash.app/management/v1/api-keys/KEY_1')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::APIKey.make_api_key.to_json)
    api_key = CashAppPay::APIKey.retrieve(id: 'KEY_1')
    assert_equal 'string', api_key.reference_id
  end

  def test_list
    stub_request(:get, 'https://sandbox.api.cash.app/management/v1/api-keys?limit=5')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::APIKey.make_api_key_list.to_json)
    api_keys = CashAppPay::APIKey.list({ limit: 5 })
    assert_equal(Hash[:limit, 5], api_keys.filters)
    assert_equal 'string', api_keys.data[0].reference_id
    assert_equal 'Cgl0dmNqa3R4MHk=', api_keys.cursor
  end

  def test_create
    params = CashAppPay::TestData::APIKey.make_params
    stub_request(:post, 'https://sandbox.api.cash.app/management/v1/api-keys')
      .with(
        body: Hash[:api_key, params, :idempotency_key, 'idempotency'].to_json,
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::APIKey.make_api_key.to_json)
    params_with_idempotency = params.merge(idempotency_key: 'idempotency')
    api_key = CashAppPay::APIKey.create(params_with_idempotency)
    assert_equal 'string', api_key.reference_id
  end
end
