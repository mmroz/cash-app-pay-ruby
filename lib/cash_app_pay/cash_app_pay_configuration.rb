# frozen_string_literal: true

module CashAppPay
  class CashAppPayConfiguration
    attr_accessor :client_id, :api_base, :region, :signature, :api_key

    def self.setup
      new.tap do |instance|
        yield(instance) if block_given?
      end
    end

    def initialize
      @api_base = Endpoint::Production
    end
  end
end
