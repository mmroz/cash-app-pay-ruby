# frozen_string_literal: true

module CashAppPay
  module APIOperations
    module Save
      # TODO: - currently updating a property then calling update does not work
      # in the future update this so that we can call:
      # cr = CashAppPay::CustomerRequest.retrieve(...)
      # cr.metadata = {new: :value}
      # cr.update
      # right now we have to call cr.update({request: {metadata: {new: :value}}})
      def update(params = {}, opts = {})
        resource_parameters = self.class.resource_parameters(params)
        response, opts = request_cash_app_pay_object(
          method: :patch,
          path: resource_url,
          params: resource_parameters,
          opts: opts
        )
        !initialize_from(response.data, opts)&.values&.empty?
      end

      def save(opts = {})
        resource_parameters = self.class.resource_parameters(@values)
        response, opts = request_cash_app_pay_object(
          method: :post,
          path: self.class.resource_url,
          params: Utils.params_with_idempotency_key(resource_parameters),
          opts: opts
        )
        !initialize_from(response.data, opts)&.values&.empty?
      end
    end
  end
end
