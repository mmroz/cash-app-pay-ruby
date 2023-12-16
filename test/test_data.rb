# frozen_string_literal: true

module CashAppPay
  module TestData
    def self.idempotency_key
      'C69597D4-B7B0-47A2-BAA8-5628F1E1BDC0'
    end

    def self.make_pending_customer_request
      {
        request: {
          id: 'GRR_t4yqhj55qn6b8hxf24fj88w2',
          status: 'PENDING',
          actions: [
            {
              type: 'ONE_TIME_PAYMENT',
              amount: 100, currency: 'USD',
              scope_id: 'BRAND_9t4pg7c16v4lukc98bm9jxyse'
            }
          ],
          origin: {
            type: 'DIRECT'
          },
          auth_flow_triggers: {
            qr_code_image_url: 'https://sandbox.api.cash.app/qr/sandbox/v1/GRR_t4yqhj55qn6b8hxf24fj88w2-6aph6n?rounded=0&logoColor=0000ff&format=png', qr_code_svg_url: 'https://sandbox.api.cash.app/qr/sandbox/v1/GRR_t4yqhj55qn6b8hxf24fj88w2-6aph6n?rounded=0&logoColor=0000ff&format=svg', mobile_url: 'https://sandbox.api.cash.app/sandbox/v1/GRR_t4yqhj55qn6b8hxf24fj88w2-6aph6n?method=mobile_url&type=cap&fallback=liaison', refreshes_at: '2023-12-15T01:08:31.172Z'
          }, created_at: '2023-12-15T01:07:01.202Z', updated_at: '2023-12-15T01:08:01.172Z', expires_at: '2023-12-15T02:07:01.172Z', requester_profile: { name: 'Mobile SDK: The iOS Brand', logo_url: 'https://franklin-assets.s3.amazonaws.com/merchants/assets/v3/generic/m_category_shopping.png' }, redirect_url: 'paykitdemo://callback', channel: 'IN_APP'
        }
      }
    end

    def self.make_customer_request_create_params
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
    end

    def self.make_customer_request_update_params
      {
        "actions": [
          {
            "amount": 2500,
            "currency": 'USD',
            "scope_id": 'BRAND_9t4pg7c16v4lukc98bm9jxyse',
            "type": 'ONE_TIME_PAYMENT'
          }
        ],
        "reference_id": 'string',
        "metadata": {
          "key": 'value'
        }
      }
    end

    def self.make_customer_request_update_params_json
      Hash[:request, make_customer_request_update_params].to_json
    end

    def self.make_customer_request_create_params_json
      Hash[:request, make_customer_request_create_params, :idempotency_key, idempotency_key].to_json
    end

    def self.make_response_headers(client_id)
      {
        'Accept' => 'application/json',
        'Authorization' => "Client #{client_id}",
        'Content-Type' => 'application/json'
      }
    end
  end
end
