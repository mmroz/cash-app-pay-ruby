# frozen_string_literal: true

module CashAppPay
  module APIOperations
    module Request
      module ClassMethods
        def execute_resource_request(method, url, params = nil, opts = {})
          response = CashAppPay::CashAppPayClient.execute_api_request(method, url, params, opts)
          [response, opts]
        end

        def self.included(base)
          base.extend(ClassMethods)
        end

        private

        def request_cash_app_pay_object(method:, path:, params:, opts: {})
          body = encode_body(params) unless params.nil?
          response, opts = execute_resource_request(method, path, body, opts)
          initialize_from_net_response(response, opts)
        end
      end
    end
  end
end
