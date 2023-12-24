# frozen_string_literal: true

module CashAppPay
  class Payment < APIResource
    extend CashAppPay::APIOperations::Create
    include CashAppPay::APIOperations::Save
    extend CashAppPay::APIOperations::List
    include CashAppPay::APIOperations::Retrieve

    def self.resource_url
      '/network/v1/payments'
    end

    def self.object_name
      :payment
    end

    def capture(params = {}, opts = {})
      request_cash_app_pay_object(
        method: :post,
        path: format('/network/v1/payments/%<payment>s/capture', { payment: CGI.escape(self) }),
        params: params,
        opts: opts
      )
    end

    def self.capture(payment, params = {}, opts = {})
      request_cash_app_pay_object(
        method: :post,
        path: format('/network/v1/payments/%<payment>s/capture', { payment: CGI.escape(payment) }),
        params: params,
        opts: opts
      )
    end

    def void(opts = {})
      request_cash_app_pay_object(
        method: :post,
        path: format('/network/v1/payments/%<payment>s/void', { payment: CGI.escape(self) }),
        params: nil,
        opts: opts
      )
    end

    def self.void(payment, opts = {})
      request_cash_app_pay_object(
        method: :post,
        path: format('/network/v1/payments/%<payment>s/void', { payment: CGI.escape(payment) }),
        params: nil,
        opts: opts
      )
    end

    def self.void_by_idempotency_key(idempotency_key, opts = {})
      request_cash_app_pay_object(
        method: :post,
        path: 'network/v1/payments/void-by-idempotency-key',
        params: { idempotency_key: idempotency_key },
        opts: opts
      )
    end
  end
end
