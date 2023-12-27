# frozen_string_literal: true

module CashAppPay
  module APIOperations
    module Request
      def request_cash_app_pay_object(method:, path:, params:, opts: {})
        body = self.class.encode_body(params) unless params.nil?
        response, opts = self.class.execute_resource_request(method: method, url: path, body_params: body, opts: opts)
        initialize_from(response.data, opts)
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

      private

      def delete_cash_app_pay_object(path:, opts: {})
        response, = execute_resource_request(method: :delete, url: path, opts: opts)
        response.http_status == 200
      end

      module ClassMethods
        def execute_resource_request(method:, url:, url_params: nil, body_params: nil, opts: {})
          response = CashAppPay::CashAppPayClient.execute_request(method_name: method, path: url,
                                                                  url_params: url_params, body_params: body_params, opts: opts)
          [response, opts]
        end

        def request_cash_app_pay_object(method:, path:, params:, opts: {})
          body = encode_body(params) unless params.nil?
          response, opts = execute_resource_request(method: method, url: path, body_params: body, opts: opts)
          initialize_from_net_response(response, opts)
        end

        private

        def delete_cash_app_pay_object(path:, opts: {})
          response, = execute_resource_request(method: :delete, url: path, opts: opts)
          response.http_status == 200
        end
      end
    end
  end
end
