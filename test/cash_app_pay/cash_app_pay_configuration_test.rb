# frozen_string_literal: true

require File.expand_path('../test_helper', __dir__)

class CashAppPayConfigurationTest < Test::Unit::TestCase
  def test_that_default_api_base_is_sandbox
    config = CashAppPay::CashAppPayConfiguration.new
    assert_equal 'api.cash.app', config.api_base
  end
end
