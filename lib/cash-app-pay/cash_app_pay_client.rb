# frozen_string_literal: true

module CashAppPay
  class CashAppPayClient
    def self.execute_api_request(method_name, path, body = nil, opts = {})
      base_uri = opts[:api_base] || CashAppPay.api_base

      method = method_name.to_s.upcase
      url = URI::HTTPS.build(host: base_uri, path: path)

      http = CashAppPay::PersistentHttpClient.get(url)

      headers = if path.start_with?(NETWORK_API_PATH_PREFIX) || path.start_with?(MANAGE_API_PATH_PREFIX)
                  build_network_api_headers(opts)
                elsif path.start_with?(CUSTOMER_REQUEST_API_PATH_PREFIX)
                  build_customer_request_api_headers(opts)
                else
                  raise InvalidRequestError.new('path', '')
                end

      request = Net::HTTPGenericRequest.new(method, !body.nil?, true, url, headers)
      request.body = body unless body.nil?

      response = http.request(request)

      # response_code = response.code.to_i
      CashAppPayResponse.from_net_http(response)

      # http = Net::HTTP.new(url.host, url.port)
      # http.use_ssl = true
      #
      # request = Net::HTTPGenericRequest.new(method, !body.nil?, true, url, headers)
      # request.body = body unless body.nil?
      #
      # response = http.request(request)
      # CashAppPayResponse.from_net_http(response)
    end

    CUSTOMER_REQUEST_API_PATH_PREFIX = '/customer-request/'
    NETWORK_API_PATH_PREFIX = '/network/'
    MANAGE_API_PATH_PREFIX = '/management/'

    def self.build_customer_request_api_headers(opts)
      client_id = opts[:client_id] || CashAppPay.client_id
      {
        "Authorization": ['Client', client_id].join(' '),
        "Accept": 'application/json',
        "Content-Type": 'application/json'
      }
    end

    def self.build_network_api_headers(opts)
      client_id = opts[:client_id] || CashAppPay.client_id
      api_key = opts[:api_key] || CashAppPay.api_key
      signature = opts[:signature] || CashAppPay.signature
      region = opts[:region] || CashAppPay.region

      authorization = ['Client', client_id, api_key].join(' ')
      {
        "Authorization": authorization,
        "X-Region": region,
        "X-Signature": signature,
        "Accept": 'application/json',
        "Content-Type": 'application/json'
      }
    end
  end
end
