# frozen_string_literal: true

module CashAppPay
  class APIKey < APIResource
    extend CashAppPay::APIOperations::Create
    include CashAppPay::APIOperations::Save
    extend CashAppPay::APIOperations::List
    include CashAppPay::APIOperations::Retrieve

    def self.resource_url
      '/management/v1/api-keys'
    end

    def self.object_name
      :api_key
    end
  end
end
