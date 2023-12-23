# frozen_string_literal: true

require File.expand_path('../test_helper', __dir__)

class APIResourceTest < Test::Unit::TestCase
  def test_that_api_resource_has_opts
    resource = CashAppPay::APIResource.new({}, { api_client: 1 })
    assert_equal({ api_client: 1 }, resource.opts)
  end

  def test_that_api_resource_has_values
    resource = CashAppPay::APIResource.new({ id: 1 })
    assert_equal({ id: 1 }, resource.values)
  end

  def test_that_resource_url_throws_error
    assert_raise NotImplementedError do
      CashAppPay::APIResource.resource_url
    end
  end
end
