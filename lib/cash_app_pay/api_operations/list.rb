# frozen_string_literal: true

module CashAppPay
  module APIOperations
    module List
      def list(filters = {}, opts = {})
        response, opts = execute_resource_request(
          method: :get,
          url: resource_url,
          url_params: filters,
          opts: opts
        )
        ListObject.initialize_from_response(self, response, opts, filters)
      end
    end
  end
end
