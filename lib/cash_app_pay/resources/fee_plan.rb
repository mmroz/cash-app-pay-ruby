# frozen_string_literal: true

module CashAppPay
  class FeePlan < APIResource
    extend CashAppPay::APIOperations::List
    include CashAppPay::APIOperations::Retrieve

    def self.resource_url
      '/network/v1/fee-plans'
    end

    def self.object_name
      :fee_plan
    end
  end
end
