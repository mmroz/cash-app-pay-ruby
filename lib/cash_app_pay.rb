# frozen_string_literal: true

require 'json'
require 'cgi'
require 'forwardable'
require 'uri'
require 'net/http'
require 'byebug'
require 'securerandom'
require 'time'

# Version
require 'cash_app_pay/version'

# Helpers
require 'cash_app_pay/helpers/symbolize'

# API operations
require 'cash_app_pay/api_operations/create'
require 'cash_app_pay/api_operations/list'
require 'cash_app_pay/api_operations/request'
require 'cash_app_pay/api_operations/update'
require 'cash_app_pay/api_operations/save'
require 'cash_app_pay/api_operations/retrieve'
require 'cash_app_pay/api_operations/upsert'

require 'cash_app_pay/errors'
require 'cash_app_pay/utils'
require 'cash_app_pay/connection_manager'
require 'cash_app_pay/persistent_http_client'
require 'cash_app_pay/cash_app_pay_client'
require 'cash_app_pay/cash_app_pay_object'
require 'cash_app_pay/cash_app_pay_response'
require 'cash_app_pay/list_object'
require 'cash_app_pay/api_resource'
require 'cash_app_pay/cash_app_pay_configuration'

# Named API resources
require 'cash_app_pay/resources/customer_request'
require 'cash_app_pay/resources/payment'
require 'cash_app_pay/resources/webhook'
require 'cash_app_pay/resources/fee_plan'
require 'cash_app_pay/resources/customer'
require 'cash_app_pay/resources/grant'
require 'cash_app_pay/resources/brand'
require 'cash_app_pay/resources/dispute'
require 'cash_app_pay/resources/dispute_evidence'
require 'cash_app_pay/resources/merchant'
require 'cash_app_pay/resources/refund'
require 'cash_app_pay/resources/api_key'

module CashAppPay
  @config = CashAppPay::CashAppPayConfiguration.setup

  class << self
    extend Forwardable

    attr_accessor :config

    def_delegators :@config, :api_base, :api_base=
    def_delegators :@config, :client_id, :client_id=
    def_delegators :@config, :region, :region=
    def_delegators :@config, :signature, :signature=
    def_delegators :@config, :api_key, :api_key=
  end
end
