# frozen_string_literal: true

module CashAppPay
  module APIOperations
    module Create
      def create(params = {}, opts = {})
        request_cash_app_pay_object(
          method: :post,
          path: resource_url,
          params: params,
          opts: opts
        )
      end
    end
  end
end
