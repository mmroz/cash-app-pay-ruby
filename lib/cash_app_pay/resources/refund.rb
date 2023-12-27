# frozen_string_literal: true

module CashAppPay
  class Refund < APIResource
    extend CashAppPay::APIOperations::Create
    extend CashAppPay::APIOperations::List
    include CashAppPay::APIOperations::Retrieve

    def self.resource_url
      '/network/v1/refunds'
    end

    def self.object_name
      :refund
    end

    def capture(params = {}, opts = {})
      request_cash_app_pay_object(
        method: :post,
        path: format('/network/v1/refunds/%<refund>s/capture', { refund: CGI.escape(self) }),
        params: params,
        opts: opts
      )
    end

    def self.capture(refund, params = {}, opts = {})
      request_cash_app_pay_object(
        method: :post,
        path: format('/network/v1/refunds/%<refund>s/capture', { refund: CGI.escape(refund) }),
        params: params,
        opts: opts
      )
    end

    def void(opts = {})
      request_cash_app_pay_object(
        method: :post,
        path: format('/network/v1/refunds/%<refund>s/void', { refund: CGI.escape(self) }),
        params: nil,
        opts: opts
      )
    end

    def self.void(refund, opts = {})
      request_cash_app_pay_object(
        method: :post,
        path: format('/network/v1/refunds/%<refund>s/void', { refund: CGI.escape(refund) }),
        params: nil,
        opts: opts
      )
    end

    def self.void_by_idempotency_key(params = {}, opts = {})
      request_cash_app_pay_object(
        method: :post,
        path: '/network/v1/refunds/void-by-idempotency-key',
        params: params,
        opts: opts
      )
    end
  end
end
