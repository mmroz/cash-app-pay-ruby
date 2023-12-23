# frozen_string_literal: true

module CashAppPay
  module APIOperations
    module List
      def list(filters = {}, opts = {})
        response, opts = request_cash_app_pay_object(
          method: :get,
          path: resource_url,
          params: filters,
          opts: opts
        )
        ListObject.initialize_from_response(self, response, opts, filters)
      end
    end
  end
end
