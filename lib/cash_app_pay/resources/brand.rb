# frozen_string_literal: true

module CashAppPay
  class Brand < APIResource
    extend CashAppPay::APIOperations::Create
    include CashAppPay::APIOperations::Save
    extend CashAppPay::APIOperations::List
    include CashAppPay::APIOperations::Retrieve
    include CashAppPay::APIOperations::Update

    def self.resource_url
      '/network/v1/brands'
    end

    def self.object_name
      :brand
    end

    def self.upsert(brand, params = {}, opts = {})
      request_cash_app_pay_object(
        method: :put,
        path: "#{resource_url}/#{CGI.escape(brand)}",
        params: params,
        opts: opts
      )
    end
  end
end
