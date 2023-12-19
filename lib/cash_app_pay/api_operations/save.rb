# frozen_string_literal: true

module CashAppPay
  module APIOperations
    module Save
      def save(opts = {})
        resource_parameters = self.class.resource_parameters(@values)
        response, opts = request_cash_app_pay_object(
          method: :post,
          path: self.class.resource_url,
          params: Utils.params_with_idempotency_key(resource_parameters),
          opts: opts
        )
        initialize_from(response.data, opts)&.errors&.empty? || true
      end
    end
  end
end
