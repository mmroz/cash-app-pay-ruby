# frozen_string_literal: true

module CashAppPay
  class Payment < APIResource
    extend CashAppPay::APIOperations::Create
    include CashAppPay::APIOperations::Save
    extend CashAppPay::APIOperations::List

    def self.resource_url
      '/network/v1/payments'
    end

    def self.object_name
      :payment
    end

    def capture(params = {}, opts = {})
      body_params = Utils.params_with_idempotency_key(params)
      response, opts = request_cash_app_pay_object(
        method: :post,
        path: format('/network/v1/payments/%<payment>s/capture', { payment: CGI.escape(self['id']) }),
        params: body_params,
        opts: opts
      )
      initialize_from(response.data, opts)
    end

    def self.capture(payment, params = {}, opts = {})
      debugger
      body_params = Utils.params_with_idempotency_key(params)
      response, opts = request_cash_app_pay_object(
        method: :post,
        path: format('/network/v1/payments/%<payment>s/capture', { payment: CGI.escape(payment) }),
        params: body_params,
        opts: opts
      )
      initialize_from_net_response(response, opts)
    end

    def void(opts = {})
      response, opts = request_cash_app_pay_object(
        method: :post,
        path: format('/network/v1/payments/%<payment>s/void', { payment: CGI.escape(self['id']) }),
        params: nil,
        opts: opts
      )
      initialize_from(response.data, opts)
    end

    def self.void(payment, opts = {})
      response, opts = request_cash_app_pay_object(
        method: :post,
        path: format('/network/v1/payments/%<payment>s/void', { payment: CGI.escape(payment) }),
        params: nil,
        opts: opts
      )
      initialize_from_net_response(response, opts)
    end

    def self.void_by_idempotency_key(idempotency_key, opts = {})
      response, opts = request_cash_app_pay_object(
        method: :post,
        path: 'network/v1/payments/void-by-idempotency-key',
        params: { idempotency_key: idempotency_key },
        opts: opts
      )
      initialize_from_net_response(response, opts)
    end
  end
end
