# frozen_string_literal: true

require File.expand_path('../../test_helper', __dir__)

class BrandTest < Test::Unit::TestCase
  def setup
    CashAppPay.api_base = CashAppPay::TestData::API::API_BASE
    CashAppPay.client_id = CashAppPay::TestData::API::CLIENT_ID
    CashAppPay.region = CashAppPay::TestData::API::REGION
    CashAppPay.signature = CashAppPay::TestData::API::SIGNATURE
    CashAppPay.api_key = CashAppPay::TestData::API::API_KEY
  end

  def test_refresh
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/brands/b_1')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Brand.make_brand.to_json)
    brand = CashAppPay::Brand.new(id: 'b_1')
    brand.refresh
    assert_equal 'Out of this World', brand.name
  end

  def test_retrieve
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/brands/b_1')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Brand.make_brand.to_json)
    brand = CashAppPay::Brand.retrieve(id: 'b_1')
    assert_equal 'Out of this World', brand.name
  end

  def test_list
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/brands?limit=5')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Brand.make_brand_list.to_json)
    brands = CashAppPay::Brand.list({ limit: 5 })
    assert_equal(Hash[:limit, 5], brands.filters)
    assert_equal 'Out of this World', brands.data[0].name
    assert_equal 'Cgl0dmNqa3R4MHk=', brands.cursor
  end

  def test_create
    params = CashAppPay::TestData::Brand.make_params
    stub_request(:post, 'https://sandbox.api.cash.app/network/v1/brands')
      .with(
        body: Hash[:brand, params, :idempotency_key, 'idempotency'].to_json,
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Brand.make_brand.to_json, headers: {})
    params_with_idempotency = params.merge(idempotency_key: 'idempotency')
    brand = CashAppPay::Brand.create(params_with_idempotency)
    assert_equal 'Out of this World', brand.name
  end

  def test_update
    stub_request(:patch, 'https://sandbox.api.cash.app/network/v1/brands/b_1')
      .with(
        body: Hash[:brand, CashAppPay::TestData::Brand.make_params].to_json,
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Brand.make_brand.to_json, headers: {})
    brand = CashAppPay::Brand.update('b_1', CashAppPay::TestData::Brand.make_params)
    assert_equal 'Out of this World', brand.name
  end

  def test_upsert
    stub_request(:put, 'https://sandbox.api.cash.app/network/v1/brands/b_1')
      .with(
        body: Hash[:brand, CashAppPay::TestData::Brand.make_params].to_json,
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Brand.make_brand.to_json, headers: {})
    brand = CashAppPay::Brand.upsert('b_1', CashAppPay::TestData::Brand.make_params)
    assert_equal 'Out of this World', brand.name
  end
end
