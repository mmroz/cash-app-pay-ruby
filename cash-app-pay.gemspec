$LOAD_PATH.unshift(::File.join(::File.dirname(__FILE__), "lib"))

require 'cash-app-pay/version'

Gem::Specification.new do |s|
  s.name        = "cash_app_pay"
  s.version     = "1.0.0"
  s.summary     = "Cash App Pay"
  s.description = "Cash App Pay gem"
  s.authors     = ["Mark Mroz"]
  s.email       = "mmroz@squareup.com"
  s.homepage    = "https://rubygems.org/gems/hola"
  s.license     = "MIT"

  s.files = [
    'lib/cash-app-pay/version.rb',
    'lib/cash-app-pay/helpers/symbolize.rb',
    'lib/cash-app-pay/api_operations/create.rb',
    'lib/cash-app-pay/api_operations/list.rb',
    'lib/cash-app-pay/api_operations/request.rb',
    'lib/cash-app-pay/api_operations/update.rb',
    'lib/cash-app-pay/api_operations/save.rb',
    'lib/cash-app-pay/errors.rb',
    'lib/cash-app-pay/utils.rb',
    'lib/cash-app-pay/connection_manager.rb',
    'lib/cash-app-pay/persistent_http_client.rb',
    'lib/cash-app-pay/cash_app_pay_client.rb',
    'lib/cash-app-pay/cash_app_pay_object.rb',
    'lib/cash-app-pay/cash_app_pay_response.rb',
    'lib/cash-app-pay/list_object.rb',
    'lib/cash-app-pay/api_resource.rb',
    'lib/cash-app-pay/cash_app_pay_configuration.rb',
    'lib/cash-app-pay/resources/customer_request.rb',
    'lib/cash-app-pay/resources/payment.rb',
    'lib/cash-app-pay/resources/webhook.rb'
  ]

  s.require_paths = ['lib']
end