# frozen_string_literal: true

require 'cash_app_pay/version'

module CashAppPay
  class CashAppPayClient
    def self.execute_request(method_name:, path:, url_params:, body_params: nil, opts: {})
      base_uri = opts[:api_base] || CashAppPay.api_base
      client_id = opts[:client_id] || CashAppPay.client_id

      check_client_id!(client_id)

      method = method_name.to_s.upcase
      url = URI::HTTPS.build(host: base_uri, path: path)
      url.query = URI.encode_www_form(url_params) if !url_params.nil? && !url_params.empty?
      http = CashAppPay::PersistentHttpClient.get(url)

      headers = if path.start_with?(NETWORK_API_PATH_PREFIX) || path.start_with?(MANAGE_API_PATH_PREFIX)
                  network_api_headers(client_id, opts)
                elsif path.start_with?(CUSTOMER_REQUEST_API_PATH_PREFIX)
                  customer_request_api_headers(client_id)
                else
                  raise InvalidRequestError.new('path', '')
                end

      request = Net::HTTPGenericRequest.new(method, !body_params.nil?, true, url, headers)
      request.body = body_params unless body_params.nil?

      response = http.request(request)

      begin
        resp = CashAppPayResponse.from_net_http(response)
        handle_error_response(resp.error_data) if resp.error_data
      rescue JSON::ParserError
        raise general_api_error(response.code.to_i, response.body)
      end

      resp
    end

    def self.handle_error_response(response_errors)
      return unless (error_response = response_errors.first)

      raise APIResponseError, error_response
    end

    def self.check_client_id!(client_id)
      return if client_id

      raise AuthenticationError, 'No Client ID provided. Set your API key using CashAppPay.client_id = <CLIENT-ID>'
    end

    def self.check_api_base!(api_base)
      return if api_base

      raise AuthenticationError, 'No API base provided. Set your API key using CashAppPay.api_base = <API-BASE>'
    end

    def self.check_region!(region)
      raise AuthenticationError, 'No Region provided. Set your API key using CashAppPay.region = <REGION>' unless region
    end

    def self.check_signature!(signature)
      return if signature

      raise AuthenticationError, 'No Signature provided. Set your API key using CashAppPay.signature = <SIGNATURE>'
    end

    def self.check_api_key!(api_key)
      return if api_key

      raise AuthenticationError, 'No Region provided. Set your API key using CashAppPay.api_key = <API-KEY>'
    end

    def self.general_api_error(status, body)
      APIError.new("Invalid response object from API: #{body.inspect} (HTTP response code was #{status})",
                   http_status: status, http_body: body)
    end

    def self.user_agent
      "cash-app-pay-ruby/v#{CashAppPay::VERSION} RubyBindings (#{RUBY_VERSION} p#{RUBY_PATCHLEVEL} (#{RUBY_RELEASE_DATE})) RUBY_PLATFORM #{defined?(RUBY_ENGINE) ? "(#{RUBY_ENGINE})" : ''}"
    end

    CUSTOMER_REQUEST_API_PATH_PREFIX = '/customer-request/'
    NETWORK_API_PATH_PREFIX = '/network/'
    MANAGE_API_PATH_PREFIX = '/management/'

    def self.customer_request_api_headers(client_id)
      {
        "Authorization": ['Client', client_id].join(' '),
        "Accept": 'application/json',
        "Content-Type": 'application/json',
        "User-Agent": user_agent
      }
    end

    def self.network_api_headers(client_id, opts)
      api_key = opts[:api_key] || CashAppPay.api_key
      signature = opts[:signature] || CashAppPay.signature
      region = opts[:region] || CashAppPay.region

      check_api_key!(api_key)
      check_signature!(signature)
      check_region!(region)

      authorization = ['Client', client_id, api_key].join(' ')
      {
        "Authorization": authorization,
        "X-Region": region,
        "X-Signature": signature,
        "Accept": 'application/json',
        "Content-Type": 'application/json',
        "User-Agent": user_agent
      }
    end
  end
end
