# frozen_string_literal: true

require File.expand_path('test_helper', __dir__)

class CashAppPayTest < Test::Unit::TestCase
  def test_that_api_base_can_be_configured
    CashAppPay.api_base = 'test'
    assert_equal 'test', CashAppPay.api_base
  end

  def test_that_client_id_can_be_configured
    CashAppPay.client_id = 'test'
    assert_equal 'test', CashAppPay.api_base
  end
end
