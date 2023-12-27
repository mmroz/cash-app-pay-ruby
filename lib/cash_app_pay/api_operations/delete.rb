# frozen_string_literal: true

module CashAppPay
  module APIOperations
    module Delete
      def delete(opts = {})
        delete_cash_app_pay_object(
          path: resource_url,
          opts: opts
        )
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def delete(resource, _params = {}, opts = {})
          delete_cash_app_pay_object(
            path: "#{resource_url}/#{CGI.escape(resource)}",
            opts: opts
          )
        end
      end
    end
  end
end
