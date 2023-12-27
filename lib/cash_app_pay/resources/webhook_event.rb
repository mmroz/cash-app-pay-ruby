# frozen_string_literal: true

module CashAppPay
  class WebhookEvent < APIResource
    extend CashAppPay::APIOperations::List

    def self.resource_url
      '/management/v1/webhook-events'
    end

    def self.object_name
      :webhook_event
    end
  end
end
