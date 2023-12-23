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

# debugger
# CashAppPay::CustomerRequest.retrieve('GRR_t4r3qv0esa8d4p44nxtkasqa')
# puts 'hello'
# begin\; CashAppPay::CustomerRequest.retrieve('GRR_t4r3qv0esa8d4p44nxtkasqa') \; rescue Exception => e\; puts e.backtrace end

# Create customer Request

# params = { 'channel' => 'ONLINE',
#            'redirect_url' => 'paykitdemo://callback',
#            'actions' =>
#       [
#         {
#           'currency' => 'USD',
#           'amount' => 100,
#           'type' => 'ONE_TIME_PAYMENT',
#           'scope_id' => 'BRAND_3j34fnbmjqs8jf5u67j25fow3'
#         }
#       ],
#            'idempotency_key' => 'abc-123' }
# debugger
# customer_request = CashAppPay::CustomerRequest.create(params)
# puts 'Created: '
# debugger
# puts customer_request
# debugger
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
# debugger
# saved = CashAppPay::CustomerRequest.new(params)
# saved.save
# debugger
# puts 'Saved: '
# puts saved

# debugger

# update_params = { "actions": [
#                     {
#                       "amount": 2500,
#                       "currency": 'USD',
#                       "scope_id": 'BRAND_9t4pg7c16v4lukc98bm9jxyse',
#                       "type": 'ONE_TIME_PAYMENT'
#                     }
#                   ],
#                   "reference_id": 'string',
#                   "metadata": {
#                     "key": 'value'
#                   } }

# debugger

# saved.update(update_params)
# debugger

# Payments
# Get payment
# payment = CashAppPay::Payment.retrieve('PWC_b1qk4mykgq3nbrdt2k4fpq3r8')
# debugger
# puts payment.id
# debugger

# debugger
# payments = CashAppPay::Payment.list({})
# puts payments[0]
# puts payments.each do |p| p.id end
# puts payments.next_page
# puts payments.auto_paging_each do |p| p.id end
# puts 'a'
# debugger
#
# payment = CashAppPay::Payment.retrieve('PWC_b1qk4mykgq3nbrdt2k4fpq3r8')
# # payment = payment.capture({amount: 100})
#
# CashAppPay::Payment.capture(payment, { amount: 100 })
# payment = CashAppPay::Payment.capture('PWC_b1qk4mykgq3nbrdt2k4fpq3r8', { amount: 100 })
# puts payment
# debugger

# debugger
# payments = CashAppPay::Webhook.list({})
# debugger
# payments = CashAppPay::Webhook.retrieve('WC_bpyng096855q5muggzxwgvl99')
# debugger
# puts payments[0]
# puts payments.each do |p| p.id end
# puts payments.next_page
# puts payments.auto_paging_each do |p| p.id end
# puts 'a'
# debugger
