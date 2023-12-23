# frozen_string_literal: true

require File.expand_path('../test_helper', __dir__)

class CashAppPayObjectTest < Test::Unit::TestCase
  def test_that_properties_are_accessible_by_dot_notation
    object = CashAppPay::CashAppPayObject.new({ id: 1 })
    assert_equal 1, object.id
  end

  def test_that_missing_properties_can_be_set_and_retrieved
    object = CashAppPay::CashAppPayObject.new({})
    object.id = 1
    assert_equal 1, object.id
  end

  def test_that_hashes_can_be_set_and_retrieved
    object = CashAppPay::CashAppPayObject.new({})
    object.metadata = { hello: :world }
    assert_equal CashAppPay::CashAppPayObject({ helo: :world }), object.metadata
  end

  def test_that_they_are_equatable
    object = CashAppPay::CashAppPayObject.new({ id: 1 })
    assert_equal CashAppPay::CashAppPayObject.new({ id: 1 }), object
    assert_not_equal CashAppPay::CashAppPayObject.new({ id: 2 }), object
  end

  def test_that_values_are_serialized_to_json
    object = CashAppPay::CashAppPayObject.new({ id: 1 })
    assert_equal object.to_json, { id: 1 }.to_json
  end

  def test_that_values_are_retrievable_as_hash
    object = CashAppPay::CashAppPayObject.new({ id: 1 })
    assert_equal object.to_h, { id: 1 }
  end
end
