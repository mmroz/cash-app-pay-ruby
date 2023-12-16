# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'cash-app-pay/version'

Gem::Specification.new do |s|
  s.name = 'cash-app-pay'
  s.version = CashAppPay::VERSION
  s.license = 'MIT'
  s.required_ruby_version = '>= 2.3.0'
  s.summary = 'Ruby bindings for the Cash App Pay API'
  s.author = 'Cash'

  s.files = [
    'cash-app-pay/version',
    'cash-app-pay/api_operations/create',
    'cash-app-pay/api_operations/request',
    'cash-app-pay/api_operations/save',
    'cash-app-pay/errors',
    'cash-app-pay/cash_app_pay_object',
    'cash-app-pay/api_resource',
    'cash-app-pay/cash_app_pay_configuration',
    'cash-app-pay/resources/customer_request',
    'cash-app-pay/cash_app_pay_client',
    'cash-app-pay/utils'
  ]
  s.require_paths = ['lib']
end
