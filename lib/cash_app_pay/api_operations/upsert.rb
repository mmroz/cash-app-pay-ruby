# frozen_string_literal: true

module CashAppPay
  module APIOperations
    module Upsert

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def upsert(resource, params = {}, opts = {})
          request_cash_app_pay_object(
            method: :put,
            path: "#{resource_url}/#{CGI.escape(resource)}",
            params: params,
            opts: opts
          )
        end
      end
    end
  end
end
