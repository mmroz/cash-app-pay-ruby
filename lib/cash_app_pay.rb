# frozen_string_literal: true

require 'json'
require 'cgi'
require 'forwardable'
require 'uri'
require 'net/http'
require 'byebug'
require 'securerandom'

# Version
require 'cash-app-pay/version'

# Helpers
require 'cash-app-pay/helpers/symbolize'

# API operations
require 'cash-app-pay/api_operations/create'
# require "stripe/api_operations/delete"
# require "stripe/api_operations/list"
# require "stripe/api_operations/nested_resource"
require 'cash-app-pay/api_operations/request'
require 'cash-app-pay/api_operations/save'
# require "stripe/api_operations/search"
#
# # API resource support classes
require 'cash-app-pay/errors'
# require "stripe/object_types"
require 'cash-app-pay//utils'
# require "stripe/connection_manager"
# require "stripe/multipart_encoder"
require 'cash-app-pay/cash_app_pay_client'
require 'cash-app-pay/cash_app_pay_object'
require 'cash-app-pay/cash_app_pay_response'
# require "stripe/list_object"
# require "stripe/search_result_object"
# require "stripe/error_object"
require 'cash-app-pay/api_resource'
# require "stripe/api_resource_test_helpers"
# require "stripe/singleton_api_resource"a
# require "stripe/webhook"
require 'cash-app-pay/cash_app_pay_configuration'

# Named API resources
require 'cash-app-pay/resources/customer_request'
#
# # OAuth
# require "stripe/oauth"

module CashAppPay
  @config = CashAppPay::CashAppPayConfiguration.setup

  class << self
    extend Forwardable

    attr_accessor :config

    def_delegators :@config, :api_base, :api_base=
    def_delegators :@config, :client_id, :client_id=
  end
end

# debugger
# CashAppPay::CustomerRequest.retrieve('GRR_t4r3qv0esa8d4p44nxtkasqa')
# puts 'hello'
# begin\; CashAppPay::CustomerRequest.retrieve('GRR_t4r3qv0esa8d4p44nxtkasqa') \; rescue Exception => e\; puts e.backtrace end

# Create customer Request
{ 'channel' => 'IN_APP',
  'redirect_url' => 'paykitdemo://callback',
  'actions' =>
      [
        {
          'currency' => 'USD',
          'amount' => 100,
          'type' => 'ONE_TIME_PAYMENT',
          'scope_id' => 'BRAND_9t4pg7c16v4lukc98bm9jxyse'
        }
      ] }
#
# customer_request = CashAppPay::CustomerRequest.create(params)
# puts 'Created: '
# puts customer_request
#
# retrieved_customer_request = CashAppPay::CustomerRequest.retrieve(customer_request.id)
#
# puts 'Found: '
# puts retrieved_customer_request
#
# refreshed = retrieved_customer_request.refresh
#
# puts 'Refreshed: '
# puts refreshed
#
# saved = CashAppPay::CustomerRequest.new(params)
# debugger
# saved.save
# puts 'Saved: '
# puts saved
# puts saved.id
#
# update_params = { "actions": [
#     {
#       "amount": 2500,
#       "currency": 'USD',
#       "scope_id": 'BRAND_9t4pg7c16v4lukc98bm9jxyse',
#       "type": 'ONE_TIME_PAYMENT'
#     }
#   ],
#   "reference_id": 'string',
#   "metadata": {
#     "key": 'value'
#   } }
#
# saved.update(update_params)
# debugger
