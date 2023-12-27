# frozen_string_literal: true

module CashAppPay
  class Customer < APIResource
    extend CashAppPay::APIOperations::List
    include CashAppPay::APIOperations::Retrieve

    def self.resource_url
      '/network/v1/customers'
    end

    def self.object_name
      :customer
    end

    def retrieve_grant(grant, opts = {})
      CashAppPay::Grant.request_cash_app_pay_object(
        method: :get,
        path: format('/network/v1/customers/%<customer>s/grants/%<grant>s',
                     { customer: CGI.escape(self), grant: CGI.escape(grant) }),
        params: nil,
        opts: opts
      )
    end

    def self.retrieve_grant(customer, grant, opts = {})
      CashAppPay::Grant.request_cash_app_pay_object(
        method: :get,
        path: format('/network/v1/customers/%<customer>s/grants/%<grant>s',
                     { customer: CGI.escape(customer), grant: CGI.escape(grant) }),
        params: nil,
        opts: opts
      )
    end

    def revoke_grant(grant, opts = {})
      CashAppPay::Grant.request_cash_app_pay_object(
        method: :post,
        path: format('/network/v1/customers/%<customer>s/grants/%<grant>s/revoke',
                     { customer: CGI.escape(self), grant: CGI.escape(grant) }),
        params: nil,
        opts: opts
      )
    end

    def self.revoke_grant(customer, grant, opts = {})
      CashAppPay::Grant.request_cash_app_pay_object(
        method: :post,
        path: format('/network/v1/customers/%<customer>s/grants/%<grant>s/revoke',
                     { customer: CGI.escape(customer), grant: CGI.escape(grant) }),
        params: nil,
        opts: opts
      )
    end
  end
end
