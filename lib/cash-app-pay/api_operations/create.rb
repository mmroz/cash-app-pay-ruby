# frozen_string_literal: true

module CashAppPay
  module APIOperations
    module Create
      def create(params = {}, opts = {})
        body_params = resource_parameters(params)
        response, opts = request_cash_app_pay_object(
          method: :post,
          path: resource_url,
          params: Utils.params_with_idempotency_key(body_params),
          opts: opts
        )
        send(:initialize_from_net_response, response, opts)
      end
    end
  end
end
