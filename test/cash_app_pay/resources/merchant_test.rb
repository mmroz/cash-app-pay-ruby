# frozen_string_literal: true

require File.expand_path('../../test_helper', __dir__)

class MerchantTest < Test::Unit::TestCase
  def setup
    CashAppPay.api_base = CashAppPay::TestData::API::API_BASE
    CashAppPay.client_id = CashAppPay::TestData::API::CLIENT_ID
    CashAppPay.region = CashAppPay::TestData::API::REGION
    CashAppPay.signature = CashAppPay::TestData::API::SIGNATURE
    CashAppPay.api_key = CashAppPay::TestData::API::API_KEY
  end

  def test_refresh
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/merchants/MMI_1')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Merchant.make_merchant.to_json)
    merchant = CashAppPay::Merchant.new(id: 'MMI_1')
    merchant.refresh
    assert_equal 'Example Business Name', merchant.name
  end

  def test_retrieve
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/merchants/MMI_1')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Merchant.make_merchant.to_json)
    merchant = CashAppPay::Merchant.retrieve(id: 'MMI_1')
    assert_equal 'Example Business Name', merchant.name
  end

  def test_list
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/merchants?limit=5')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Merchant.make_merchant_list.to_json)
    merchants = CashAppPay::Merchant.list({ limit: 5 })
    assert_equal(Hash[:limit, 5], merchants.filters)
    assert_equal 'Example Business Name', merchants.data[0].name
    assert_equal 'Cgl0dmNqa3R4MHk=', merchants.cursor
  end

  def test_create
    params = CashAppPay::TestData::Merchant.make_params
    stub_request(:post, 'https://sandbox.api.cash.app/network/v1/merchants')
      .with(
        body: Hash[:merchant, params, :idempotency_key, 'idempotency'].to_json,
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Merchant.make_merchant.to_json, headers: {})
    params_with_idempotency = params.merge(idempotency_key: 'idempotency')
    merchant = CashAppPay::Merchant.create(params_with_idempotency)
    assert_equal 'Example Business Name', merchant.name
  end

  def test_update
    stub_request(:patch, 'https://sandbox.api.cash.app/network/v1/merchants/MMI_1')
      .with(
        body: Hash[:merchant, CashAppPay::TestData::Merchant.make_params].to_json,
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Merchant.make_merchant.to_json, headers: {})
    merchant = CashAppPay::Merchant.update('MMI_1', CashAppPay::TestData::Merchant.make_params)
    assert_equal 'Example Business Name', merchant.name
  end

  def test_upsert
    stub_request(:put, 'https://sandbox.api.cash.app/network/v1/merchants/MMI_1')
      .with(
        body: Hash[:merchant, CashAppPay::TestData::Merchant.make_params].to_json,
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Merchant.make_merchant.to_json, headers: {})
    merchant = CashAppPay::Merchant.upsert('MMI_1', CashAppPay::TestData::Merchant.make_params)
    assert_equal 'Example Business Name', merchant.name
  end
end
