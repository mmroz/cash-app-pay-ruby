# frozen_string_literal: true

module CashAppPay
  class CashAppPayClient
    def self.execute_api_request(method_name, path, body = nil, opts = {})
      base_uri = opts[:api_base] || CashAppPay.api_base
      client_id = opts[:client_id] || CashAppPay.client_id

      headers = {
        "Authorization": "Client #{client_id}",
        "Accept": 'application/json',
        "Content-Type": 'application/json'
      }

      method = method_name.to_s.upcase
      url = URI::HTTPS.build(host: base_uri, path: path)

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTPGenericRequest.new(method, !body.nil?, true, url, headers)
      request.body = body unless body.nil?

      response = http.request(request)
      CashAppPayResponse.from_net_http(response)
    end
  end
end
