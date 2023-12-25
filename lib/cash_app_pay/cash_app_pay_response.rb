# frozen_string_literal: true

module CashAppPay
  class CashAppPayResponse
    attr_accessor :http_headers, :http_status, :data, :error_data, :http_body,
                  def self.from_net_http(http_resp)
                    resp = CashAppPayResponse.new
                    resp.http_headers = http_resp.each_header.to_h
                    resp.http_status = http_resp.code.to_i
                    resp.data = JSON.parse(http_resp.read_body, symbolize_names: true)
                    resp.error_data = resp&.data&.fetch(:errors)
                    resp.http_body = http_resp.body
                    resp
                  end
  end
end
