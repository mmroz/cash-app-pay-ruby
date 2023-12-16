# frozen_string_literal: true

module CashAppPay
  class CustomerRequest < APIResource
    extend CashAppPay::APIOperations::Create
    include CashAppPay::APIOperations::Save

    def self.resource_url
      '/customer-request/v1/requests'
    end

    def self.object_name
      :request
    end
  end
end
