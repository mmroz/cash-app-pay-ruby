# frozen_string_literal: true

require File.expand_path('../test_helper', __dir__)

class CashAppPayEndpointTest < Test::Unit::TestCase
  def test_endpoints
    assert_equal 'sandbox.api.cash.app', CashAppPay::Endpoint::SANDBOX
    assert_equal 'api.cash.app', CashAppPay::Endpoint::PRODUCTION
  end
end
