# frozen_string_literal: true

module CashAppPay
  class Webhook < APIResource
    extend CashAppPay::APIOperations::Create
    include CashAppPay::APIOperations::Save
    include CashAppPay::APIOperations::Update
    extend CashAppPay::APIOperations::List
    include CashAppPay::APIOperations::Retrieve

    def self.resource_url
      '/management/v1/webhook-endpoints'
    end

    def self.object_name
      :webhook_endpoint
    end

    def self.list_webhook_events(params = {}, opts = {}); end
  end
end
