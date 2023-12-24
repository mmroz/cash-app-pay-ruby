# frozen_string_literal: true

module CashAppPay
  module TestData
    def self.idempotency_key
      'C69597D4-B7B0-47A2-BAA8-5628F1E1BDC0'
    end

    # Customer Request

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

    # Payments

    def self.make_payment
      {
        "payment": {
          "id": 'PWC_b1qk4mykgq3nbrdt2k4fpq3r8',
          "amount": 8901,
          "refunded_amount": 0,
          "captured_amount": 8901,
          "voided_amount": 0,
          "net_amount": 8901,
          "currency": 'USD',
          "customer_id": 'CST_AYVkuLxYJzXOsNYwGNTRifgOjcc43RXyKVBaUkIa0Cqg2nrD0FYSIXT5_diVv3gmHu00ykra_i-fJpPWvP505bOzYsAMZyLYSpHB9oo0CGgAIg',
          "merchant_id": 'MMI_b576ooozuetfuzdujpuggzgpx',
          "grant_id": 'GRG_AZYyHv3xSfv1Rly_oJEbZbVKepAsD5p0o3YoYE4wM-QNP0CnjtvvoRCB2TPJNdOcZ05EaNvx4mbppXxRdLlPHpEFyZs92dYGugsOSl83HyWIuo6KmtbuOvqbDPVroVwdnMUdP2f1FqcUpgjvOqjfgLTovAgprqpSCEagxeN8lHk',
          "order_id": 'ORD_dbiugt29n7iubmlcgokwl77n8',
          "status": 'CAPTURED',
          "created_at": '2023-12-17T14:29:50.700Z',
          "updated_at": '2023-12-17T14:29:53.211Z',
          "metadata": {},
          "capture_before": '2023-12-24T14:29:50.836Z'
        }
      }
    end

    def self.make_payments_list
      {
        "payments": [
          make_payment
        ],
        "cursor": 'Cgl0dmNqa3R4MHk='
      }
    end

    def self.make_payment_create_params
      { 'amount' => 100,
        'currency' => 'USD',
        'merchant_id' => 'MMI_4vxs5egfk7hmta3qx2h6rp91x',
        'grant_id' => 'GRG_221243dc6985a6819ff6950c1a21332f7bc4a46ebd49b5a7002908ab768e8e5ff7831e084d0d2c9d8d939793b55eff50',
        'reference_id' => 'external-id',
        'capture' => true,
        'metadata' => { 'key' => 'value' },
        'enrichments' => { 'recurring_series_id' => 'string' } }
    end

    def self.make_payment_create_params_json
      Hash[:payment, make_payment_create_params, :idempotency_key, idempotency_key].to_json
    end

    # Fee plan

    module FeePlan
      def self.fee_plan
        {
          "id": 'FEE_kewjsmjt35t8qhzyjeqcst5me',
          "rate": {
            "basis_points": 160,
            "fixed_amount": 20
          },
          "currency": 'USD',
          "status": 'ACTIVE',
          "reference_id": 'external-id',
          "metadata": {},
          "created_at": '2023-01-01T12:00:00Z',
          "updated_at": '2023-01-01T12:00:00Z'
        }
      end

      def make_fee_plan
        { "fee_plan": fee_plan }
      end

      def make_fee_plan_list
        { "fee_plans": [fee_plan], "cursor": 'Cgl0dmNqa3R4MHk=' }
      end

      module_function :make_fee_plan, :make_fee_plan_list
    end

    module Customer
      def self.customer
        {
          "id": 'CST_AQmxh4y_QGoNNIG5NUw0jttqyYedL1LklACQdyJ3H-Vs6WmLtP6A_C7XjQNohvY',
          "cashtag": 'string',
          "reference_id": 'CUST_123'
        }
      end

      def make_customer
        { "customer": customer }
      end

      def make_customer_list
        { "customers": [customer], "cursor": 'Cgl0dmNqa3R4MHk=' }
      end

      module_function :make_customer, :make_customer_list
    end

    module Grant
      def self.grant
        {
          "id": 'GRG_221243dc6985a6819ff6950c1a21332f7bc4a46ebd49b5a7002908ab768e8e5ff7831e084d0d2c9d8d939793b55eff50',
          "customer_id": 'CST_AQmxh4y_QGoNNIG5NUw0jttqyYedL1LklACQdyJ3H-Vs6WmLtP6A_C7XjQNohvY',
          "request_id": 'GRR_1hrxhz136krcq6ezdte2ha5q',
          "action": {
            "amount": 2500,
            "currency": 'USD',
            "scope_id": 'MMI_4vxs5egfk7hmta3qx2h6rp91x',
            "type": 'ONE_TIME_PAYMENT'
          },
          "status": 'ACTIVE',
          "type": 'ONE_TIME',
          "channel": 'ONLINE',
          "created_at": '2019-08-24T14:15:22Z',
          "updated_at": '2019-08-24T14:15:22Z',
          "expires_at": '2022-04-01T12:00:00Z'
        }
      end

      def make_grant
        { "grant": grant }
      end

      module_function :make_grant
    end

    module Brand
      def self.brand
        {
          "id": 'B_jsrnuiix',
          "name": 'Out of this World',
          "profile_image_url": 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/60/Earth_from_Space.jpg/480px-Earth_from_Space.jpg',
          "color": '#ffffff',
          "reference_id": 'external-id',
          "created_at": '2021-01-01T00:00:00Z',
          "updated_at": '2021-01-01T00:00:00Z'
        }
      end

      def make_params
        {
          "name": 'Out of this World',
          "profile_image_url": 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/60/Earth_from_Space.jpg/480px-Earth_from_Space.jpg',
          "color": '#ffffff',
          "reference_id": 'external-id',
          "metadata": {
            "key": 'value'
          }
        }
      end

      def make_brand
        { "brand": brand }
      end

      def make_brand_list
        { "brands": [brand], "cursor": 'Cgl0dmNqa3R4MHk=' }
      end

      module_function :make_brand, :make_brand_list, :make_params
    end

    module Merchant
      def self.merchant
        {
          "brand_id": "brand ID",
          "category": "5432",
          "country": "US",
          "currency": "USD",
          "name": "merchant name",
          "reference_id": "reference ID",
          "address": {
            "address_line_1": "1215 4th Ave",
            "address_line_2": "Suite 2300",
            "locality": "Seattle",
            "country": "US",
            "postal_code": "98161-1001",
            "administrative_district_level_1": "Washington"
          },
          "site_url": "https://example.com",
          "status": "ACTIVE",
          "metadata": {
            "key": "value"
          },
          "default_fee_plans": {
            "in_app_fee_plan_id": "FEE_kewjsmjt35t8qhzyjeqcst5me",
            "in_person_fee_plan_id": "FEE_kewjsmjt35t8qhzyjeqcst5me",
            "online_fee_plan_id": "FEE_kewjsmjt35t8qhzyjeqcst5me"
          }
        }
      end

      def make_params
        {
          "name": "merchant name",
          "brand_id": "brand ID",
          "country": "US",
          "currency": "USD",
          "category": "5432",
          "reference_id": "reference ID",
          "address": {
            "address_line_1": "1215 4th Ave",
            "address_line_2": "Suite 2300",
            "locality": "Seattle",
            "country": "US",
            "postal_code": "98161-1001",
            "administrative_district_level_1": "Washington"
          },
          "site_url": "https://example.com",
          "metadata": {
            "key": "value"
          },
          "default_fee_plans": {
            "in_app_fee_plan_id": "FEE_kewjsmjt35t8qhzyjeqcst5me",
            "in_person_fee_plan_id": "FEE_kewjsmjt35t8qhzyjeqcst5me",
            "online_fee_plan_id": "FEE_kewjsmjt35t8qhzyjeqcst5me"
          }
        }
      end

      def make_merchant
        { "merchant": merchant }
      end

      def make_merchant_list
        { "merchants": [merchant], "cursor": 'Cgl0dmNqa3R4MHk=' }
      end

      module_function :make_merchant, :make_merchant_list, :make_params
    end

    module API
      API_BASE = 'sandbox.api.cash.app'
      CLIENT_ID = 'test_client_id'
      REGION = 'test_region'
      SIGNATURE = 'test_signature'
      API_KEY = 'test_api_key'

      def network_api_headers(client_id = CLIENT_ID, api_key = API_KEY, region = REGION, signature = SIGNATURE)
        {
          "Authorization": "Client #{client_id} #{api_key}",
          "X-Region": region,
          "X-Signature": signature,
          "Accept": 'application/json',
          "Content-Type": 'application/json'
        }
      end

      module_function :network_api_headers
    end
  end
end
