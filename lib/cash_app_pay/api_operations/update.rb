# frozen_string_literal: true

module CashAppPay
  module APIOperations
    module Update
      def update(params = {}, opts = {})
        request_cash_app_pay_object(
          method: :patch,
          path: resource_url,
          params: self.class.encode_body(params),
          opts: opts
        )
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def update(resource, params = {}, opts = {})
          request_cash_app_pay_object(
            method: :patch,
            path: "#{self.class.resource_url}/#{CGI.escape(resource)}",
            params: params,
            opts: opts
          )
        end
      end
    end
  end
end
