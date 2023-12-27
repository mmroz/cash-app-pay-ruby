# frozen_string_literal: true

$LOAD_PATH.unshift(::File.join(::File.dirname(__FILE__), 'lib'))

require 'cash_app_pay/version'

Gem::Specification.new do |s|
  s.name        = 'cash_app_pay'
  s.version     = CashAppPay::VERSION
  s.summary     = 'Cash App Pay'
  s.description = 'Cash App Pay is the most beloved way to pay 💚. See https://cash.app for details.'
  s.authors     = ['Mark Mroz']
  s.email       = 'mmroz@squareup.com'
  s.homepage    = 'https://rubygems.org/gems/cash-app-pay'
  s.license     = 'MIT'

  s.metadata = {
    'bug_tracker_uri' => 'https://github.com/mmroz/cash-app-pay-ruby/issues',
    'changelog_uri' => 'https://github.com/mmroz/cash-app-pay-ruby/blob/main/CHANGELOG.md',
    'documentation_uri' => 'https://developers.cash.app/docs/api/welcome',
    'github_repo' => 'git@github.com:mmroz/cash-app-pay-ruby.git',
    'homepage_uri' => 'https://developers.cash.app/docs/api/welcome',
    'source_code_uri' => 'https://github.com/mmroz/cash-app-pay-ruby',
    'rubygems_mfa_required' => 'false'
  }

  s.files = [
    'lib/cash_app_pay.rb',
    'lib/cash_app_pay/version.rb',
    'lib/cash_app_pay/helpers/symbolize.rb',
    'lib/cash_app_pay/api_operations/create.rb',
    'lib/cash_app_pay/api_operations/list.rb',
    'lib/cash_app_pay/api_operations/request.rb',
    'lib/cash_app_pay/api_operations/update.rb',
    'lib/cash_app_pay/api_operations/upsert.rb',
    'lib/cash_app_pay/api_operations/save.rb',
    'lib/cash_app_pay/api_operations/retrieve.rb',
    'lib/cash_app_pay/api_operations/delete.rb',
    'lib/cash_app_pay/errors.rb',
    'lib/cash_app_pay/error_object.rb',
    'lib/cash_app_pay/endpoint.rb',
    'lib/cash_app_pay/connection_manager.rb',
    'lib/cash_app_pay/persistent_http_client.rb',
    'lib/cash_app_pay/cash_app_pay_client.rb',
    'lib/cash_app_pay/cash_app_pay_object.rb',
    'lib/cash_app_pay/cash_app_pay_response.rb',
    'lib/cash_app_pay/list_object.rb',
    'lib/cash_app_pay/api_resource.rb',
    'lib/cash_app_pay/cash_app_pay_configuration.rb',
    'lib/cash_app_pay/resources/customer_request.rb',
    'lib/cash_app_pay/resources/customer.rb',
    'lib/cash_app_pay/resources/payment.rb',
    'lib/cash_app_pay/resources/webhook.rb',
    'lib/cash_app_pay/resources/webhook_event.rb',
    'lib/cash_app_pay/resources/fee_plan.rb',
    'lib/cash_app_pay/resources/grant.rb',
    'lib/cash_app_pay/resources/brand.rb',
    'lib/cash_app_pay/resources/dispute.rb',
    'lib/cash_app_pay/resources/dispute_evidence.rb',
    'lib/cash_app_pay/resources/merchant.rb',
    'lib/cash_app_pay/resources/refund.rb',
    'lib/cash_app_pay/resources/api_key.rb'
  ]

  s.require_paths = ['lib']
end
