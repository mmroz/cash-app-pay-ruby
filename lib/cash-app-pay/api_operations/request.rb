# frozen_string_literal: true

module CashAppPay
  module APIOperations
    module Request
      module ClassMethods
        def execute_resource_request(method, url, params = nil, opts = {})
          body = CashAppPay::CashAppPayClient.execute_api_request(method, url, params, opts)
          [body, opts]
        end

        def self.included(base)
          base.extend(ClassMethods)
        end

        private

        def request_cash_app_pay_object(method:, path:, params:, opts: {})
          body = params.to_json unless params.nil?
          execute_resource_request(method, path, body, opts)
        end
      end
    end
  end
end
