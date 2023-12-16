# frozen_string_literal: true

module CashAppPay
  class CashAppPayConfiguration
    attr_accessor :client_id, :api_base

    def self.setup
      new.tap do |instance|
        yield(instance) if block_given?
      end
    end

    def initialize
      @client_id = 'CAS-CI_PAYKIT_MOBILE_DEMO' # TODO: - remove this
      @api_base = 'sandbox.api.cash.app' # TODO: - update this with prod
    end
  end
end
