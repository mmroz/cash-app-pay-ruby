# frozen_string_literal: true

module CashAppPay
  module APIOperations
    module Save
      def save(opts = {})
        request_cash_app_pay_object(
          method: :post,
          path: self.class.resource_url,
          params: @values,
          opts: opts
        )
      end
    end
  end
end
