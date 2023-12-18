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
      @client_id = 'CASH_CHECKOUT_SANDBOX' # 'CAS-CI_PAYKIT_MOBILE_DEMO' # TODO: - remove this
      @api_base = 'sandbox.api.cash.app' # TODO: - update this with prod
      @region = 'SFO' # TODO: - remove this
      @signature = 'sandbox:skip-signature-check' # TODO: - remove this
      @api_key = 'KEY_pph2za1yxkwk72wzy6k990vgx' # TODO: - remove this
    end
  end
end
