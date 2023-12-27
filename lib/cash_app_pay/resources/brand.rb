# frozen_string_literal: true

module CashAppPay
  class Brand < APIResource
    extend CashAppPay::APIOperations::Create
    include CashAppPay::APIOperations::Save
    extend CashAppPay::APIOperations::List
    include CashAppPay::APIOperations::Retrieve
    include CashAppPay::APIOperations::Update
    include CashAppPay::APIOperations::Upsert

    def self.resource_url
      '/network/v1/brands'
    end

    def self.object_name
      :brand
    end
  end
end
