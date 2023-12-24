# frozen_string_literal: true

$LOAD_PATH.unshift(::File.join(::File.dirname(__FILE__), 'lib'))

require 'cash_app_pay/version'

Gem::Specification.new do |s|
  s.name        = 'cash_app_pay'
  s.version     = '1.0.0'
  s.summary     = 'Cash App Pay'
  s.description = 'Cash App Pay gem'
  s.authors     = ['Mark Mroz']
  s.email       = 'mmroz@squareup.com'
  s.homepage    = 'https://rubygems.org/gems/hola'
  s.license     = 'MIT'

  s.files = [
    'lib/cash_app_pay.rb',

    'lib/cash_app_pay/version.rb',
    'lib/cash_app_pay/helpers/symbolize.rb',
    'lib/cash_app_pay/api_operations/create.rb',
    'lib/cash_app_pay/api_operations/list.rb',
    'lib/cash_app_pay/api_operations/request.rb',
    'lib/cash_app_pay/api_operations/update.rb',
    'lib/cash_app_pay/api_operations/save.rb',
    'lib/cash_app_pay/api_operations/retrieve.rb',
    'lib/cash_app_pay/errors.rb',
    'lib/cash_app_pay/utils.rb',
    'lib/cash_app_pay/connection_manager.rb',
    'lib/cash_app_pay/persistent_http_client.rb',
    'lib/cash_app_pay/cash_app_pay_client.rb',
    'lib/cash_app_pay/cash_app_pay_object.rb',
    'lib/cash_app_pay/cash_app_pay_response.rb',
    'lib/cash_app_pay/list_object.rb',
    'lib/cash_app_pay/api_resource.rb',
    'lib/cash_app_pay/cash_app_pay_configuration.rb',
    'lib/cash_app_pay/resources/customer_request.rb',
    'lib/cash_app_pay/resources/payment.rb',
    'lib/cash_app_pay/resources/webhook.rb',
    'lib/cash_app_pay/resources/fee_plan.rb',
    'lib/cash_app_pay/resources/grant.rb',
    'lib/cash_app_pay/resources/brand.rb'
  ]

  s.require_paths = ['lib']
end
