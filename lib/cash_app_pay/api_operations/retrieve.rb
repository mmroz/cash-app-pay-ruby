# frozen_string_literal: true

module CashAppPay
  module APIOperations
    module Retrieve
      def refresh
        response, opts = self.class.execute_resource_request(method: :get, url: resource_url, opts: @opts)
        initialize_from(response.data, opts)
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def retrieve(id, opts = {})
          instance = new({ id: id }, opts)
          instance.refresh
          instance
        end
      end
    end
  end
end
