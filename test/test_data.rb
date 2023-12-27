# frozen_string_literal: true

module CashAppPay
  module TestData
    # Disputes
    module Dispute
      def self.dispute
        {
          "id": 'DSPT_1fbjn9dg7rmz1xeyv6gkyh8vg',
          "payment_id": 'PWC_4nn21zy6t0v2yhqg5bvhk7xkq',
          "amount": 1500,
          "customer_credited_amount": 1250,
          "reason": 'FR10',
          "settlement_withholding": 'NOT_WITHHELD',
          "state": 'RESPONSE_REQUIRED',
          "created_at": '2022-01-01T12:00:00Z',
          "response_due_at": '2022-05-01T00:00:00Z',
          "updated_at": '2022-01-05T12:00:00Z',
          "merchant_id": 'MMI_4vxs5egfk7hmta3qx2h6rp91x'
        }
      end

      def make_dispute
        { "dispute": dispute }
      end

      def make_dispute_list
        { "disputes": [dispute], "cursor": 'Cgl0dmNqa3R4MHk=' }
      end

      module_function :make_dispute, :make_dispute_list
    end

    module DisputeEvidence
      def make_dispute_evidence_text_params
        {
          "category": 'GENERIC_EVIDENCE',
          "text": 'evidence as text',
          "metadata": {
            "key": 'value'
          }
        }
      end

      def self.evidence
        {
          "id": 'EVD_dbdda8e161b7bad8519f7f73',
          "dispute_id": 'DSPT_1fbjn9dg7rmz1xeyv6gkyh8vg',
          "category": 'GENERIC_EVIDENCE',
          "file": {
            "filename": 'string',
            "content_type": 'application/pdf'
          },
          "text": 'string',
          "type": 'TEXT',
          "created_at": '2022-01-01T12:00:00Z',
          "metadata": {
            "my-meta": 'meta-value'
          }
        }
      end

      def make_evidence
        { "evidence": evidence }
      end

      module_function :make_evidence, :make_dispute_evidence_text_params
    end

    # Customer Request
    module CustomerRequest
      def self.customer_request
        {
          "id": 'GRR_1hrxhz136krcq6ezdte2ha5q',
          "status": 'PENDING',
          "actions": [
            {
              "scope_id": 'MMI_4vxs5egfk7hmta3qx2h6rp91x',
              "amount": 2500,
              "currency": 'USD',
              "type": 'ONE_TIME_PAYMENT'
            }
          ],
          "auth_flow_triggers": {
            "qr_code_image_url": 'https://api.cash.app/qr/f/GRANTLY_MANAGED_GRANT%3Frequest_id=GRR_1hrxhz136krcq6ezdte2ha5q-k21srg&method=qr?rounded=0&format=png',
            "qr_code_svg_url": 'https://api.cash.app/qr/f/GRANTLY_MANAGED_GRANT%3Frequest_id=GRR_1hrxhz136krcq6ezdte2ha5q-k21srg&method=qr?rounded=0&format=svg',
            "mobile_url": 'https://cash.app/f/GRANTLY_MANAGED_GRANT%3Frequest_id=GRR_1hrxhz136krcq6ezdte2ha5q-k21srg&method=mobile_url',
            "refreshes_at": '2019-08-24T14:15:22Z',
            "desktop_url": 'https://pay.cash.app?customerRequestId=GRR_1hrxhz136krcq6ezdte2ha5q'
          },
          "redirect_url": 'https://example.com',
          "created_at": '2022-01-01T12:09:00Z',
          "updated_at": '2022-01-01T12:10:00Z',
          "expires_at": '2033-01-01T12:20:00Z',
          "origin": {
            "type": 'DIRECT',
            "id": 'string'
          },
          "channel": 'ONLINE',
          "reference_id": 'external-id',
          "requester_profile": {
            "name": 'The Sill',
            "logo_url": 'https://picsum.photos/200'
          },
          "metadata": {},
          "customer_metadata": {}
        }
      end

      def make_customer_request
        { "request": customer_request }
      end

      def make_params
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

      module_function :make_customer_request, :make_params
    end

    # Payments

    module Payment
      def self.payment
        {
          "id": 'PWC_4nn21zy6t0v2yhqg5bvhk7xkq',
          "amount": 1500,
          "net_amount": 1000,
          "captured_amount": 1000,
          "voided_amount": 0,
          "refunded_amount": 100,
          "currency": 'USD',
          "customer_id": 'CST_AQmxh4y_QGoNNIG5NUw0jttqyYedL1LklACQdyJ3H-Vs6WmLtP6A_C7XjQNohvY',
          "merchant_id": 'MMI_4vxs5egfk7hmta3qx2h6rp91x',
          "grant_id": 'GRG_221243dc6985a6819ff6950c1a21332f7bc4a46ebd49b5a7002908ab768e8e5ff7831e084d0d2c9d8d939793b55eff50',
          "status": 'AUTHORIZED',
          "created_at": '2022-01-01T12:00:00Z',
          "updated_at": '2022-01-05T12:00:00Z',
          "refund_ids": [
            'PWCR_da1v3j4p3z15y47adpzzq0whj'
          ],
          "reference_id": 'external-id',
          "metadata": {},
          "enrichments": {
            "recurring_series_id": 'string'
          },
          "decline_errors": [
            {
              "category": 'INVALID_REQUEST_ERROR',
              "code": 'MISSING_REQUIRED_FIELD',
              "detail": 'Missing required parameter.',
              "field": 'field_a[2].field_b'
            }
          ]
        }
      end

      def make_params
        {
          "amount": 100,
          "currency": 'USD',
          "merchant_id": 'MMI_4vxs5egfk7hmta3qx2h6rp91x',
          "grant_id": 'GRG_221243dc6985a6819ff6950c1a21332f7bc4a46ebd49b5a7002908ab768e8e5ff7831e084d0d2c9d8d939793b55eff50',
          "reference_id": 'external-id',
          "capture": true,
          "metadata": {
            "key": 'value'
          },
          "enrichments": {
            "recurring_series_id": 'string'
          }
        }
      end

      def make_payment
        { "payment": payment }
      end

      def make_payment_list
        { "payments": [payment], "cursor": 'Cgl0dmNqa3R4MHk=' }
      end

      module_function :make_payment, :make_payment_list, :make_params
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

    # Customer

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

    # Grant

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

    # Brand
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

    # Merchant
    module Merchant
      def self.merchant
        {

          "id": 'MMI_4vxs5egfk7hmta3qx2h6rp91x',
          "brand_id": 'BRAND_8ereg0tug2yiik8vx24xpe5br',
          "name": 'Example Business Name',
          "country": 'US',
          "currency": 'USD',
          "category": '5432',
          "reference_id": 'external-id',
          "status": 'ACTIVE',
          "created_at": '2022-01-01T12:00:00Z',
          "updated_at": '2022-01-05T12:00:00Z',
          "address": {
            "address_line_1": '1215 4th Ave',
            "address_line_2": 'Suite 2300',
            "locality": 'Seattle',
            "country": 'US',
            "postal_code": '98161-1001',
            "administrative_district_level_1": 'Washington'
          },
          "site_url": 'http://example.com',
          "metadata": {}
        }
      end

      def make_params
        {
          "name": 'merchant name',
          "brand_id": 'brand ID',
          "country": 'US',
          "currency": 'USD',
          "category": '5432',
          "reference_id": 'reference ID',
          "address": {
            "address_line_1": '1215 4th Ave',
            "address_line_2": 'Suite 2300',
            "locality": 'Seattle',
            "country": 'US',
            "postal_code": '98161-1001',
            "administrative_district_level_1": 'Washington'
          },
          "site_url": 'https://example.com',
          "metadata": {
            "key": 'value'
          },
          "default_fee_plans": {
            "in_app_fee_plan_id": 'FEE_kewjsmjt35t8qhzyjeqcst5me',
            "in_person_fee_plan_id": 'FEE_kewjsmjt35t8qhzyjeqcst5me',
            "online_fee_plan_id": 'FEE_kewjsmjt35t8qhzyjeqcst5me'
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

    # Refund

    module Refund
      def self.refund
        {
          "id": 'PWCR_da1v3j4p3z15y47adpzzq0whj',
          "amount": 2500,
          "currency": 'USD',
          "customer_id": 'CST_AQmxh4y_QGoNNIG5NUw0jttqyYedL1LklACQdyJ3H-Vs6WmLtP6A_C7XjQNohvY',
          "merchant_id": 'MMI_4vxs5egfk7hmta3qx2h6rp91x',
          "status": 'AUTHORIZED',
          "created_at": '2022-01-01T12:00:00Z',
          "updated_at": '2022-01-05T12:00:00Z',
          "grant_id": 'GRG_221243dc6985a6819ff6950c1a21332f7bc4a46ebd49b5a7002908ab768e8e5ff7831e084d0d2c9d8d939793b55eff50',
          "payment_id": 'PWC_4nn21zy6t0v2yhqg5bvhk7xkq',
          "reference_id": 'external-id',
          "metadata": {},
          "decline_errors": [
            {
              "category": 'INVALID_REQUEST_ERROR',
              "code": 'MISSING_REQUIRED_FIELD',
              "detail": 'Missing required parameter.',
              "field": 'field_a[2].field_b'
            }
          ]
        }
      end

      def make_params
        {
          "amount": 100,
          "currency": 'USD',
          "merchant_id": 'MMI_4vxs5egfk7hmta3qx2h6rp91x',
          "capture": true,
          "payment_id": 'PWC_etdng09kyyqf5zr583v8xcs2k',
          "reference_id": 'external-id',
          "metadata": {
            "key": 'value'
          }
        }
      end

      def make_refund
        { "refund": refund }
      end

      def make_refund_list
        { "refunds": [refund], "cursor": 'Cgl0dmNqa3R4MHk=' }
      end

      module_function :make_refund, :make_refund_list, :make_params
    end

    # API Key

    module APIKey
      def self.api_key
        {
          "id": 'KEY_2f6cd0d5cc26b34ac8785026b149797ecc0758be3dc3a857d405f2f62074ef30',
          "created_at": '2022-01-01T00:00:00Z',
          "expires_at": '2022-02-01T00:00:00Z',
          "scopes": [
            'PAYMENTS_READ'
          ],
          "reference_id": 'string'
        }
      end

      def make_params
        {
          "scopes": [
            'PAYMENTS_READ'
          ],
          "reference_id": 'string'
        }
      end

      def make_api_key
        { "api_key": api_key }
      end

      def make_api_key_list
        { "api_keys": [api_key], "cursor": 'Cgl0dmNqa3R4MHk=' }
      end

      module_function :make_api_key, :make_api_key_list, :make_params
    end

    # Webhook

    module Webhook
      def self.webhook_endpoint
        {
          "id": 'WC_2f6cd0d5cc26b34ac8785026b149797ecc0758be3dc3a857d405f2f62074ef30',
          "api_key_id": 'string',
          "reference_id": 'string',
          "url": 'http://example.com',
          "event_configurations": [
            {
              "event_type": 'customer.created',
              "api_version": 'v1'
            }
          ],
          "created_at": '2019-08-24T14:15:22Z',
          "updated_at": '2019-08-24T14:15:22Z',
          "delivery_timeout": 5000,
          "max_delivery_frequency": nil,
          "status": 'APPROVED'
        }
      end

      def make_params
        {
          "api_key_id": 'KEY_2f6cd0d5cc26b34ac8785026b149797ecc0758be3dc3a857d405f2f62074ef30',
          "event_configurations": [
            {
              "event_type": 'customer.created',
              "api_version": 'v1'
            }
          ],
          "url": 'string',
          "reference_id": 'string',
          "delivery_timeout": 5000,
          "max_delivery_frequency": 1
        }
      end

      def make_webhook_endpoint
        { "webhook_endpoint": webhook_endpoint }
      end

      def make_webhook_endpoint_list
        { "webhook_endpoints": [webhook_endpoint], "cursor": 'Cgl0dmNqa3R4MHk=' }
      end

      module_function :make_webhook_endpoint, :make_webhook_endpoint_list, :make_params
    end

    # Webhook Event

    module WebhookEvent
      def self.webhook_event
        {
          "id": 'WE_2f6cd0d5cc26b34ac8785026b149797ecc0758be3dc3a857d405f2f62074ef30',
          "webhook_endpoint_id": 'WC_2f6cd0d5cc26b34ac8785026b149797ecc0758be3dc3a857d405f2f62074ef30',
          "event_type": 'customer.created',
          "status": 'PENDING',
          "created_at": '2019-08-24T14:15:22Z',
          "updated_at": '2019-08-24T14:15:22Z',
          "expires_at": '2019-08-24T14:15:22Z',
          "event_data": {
            "event_id": 'WE_2f6cd0d5cc26b34ac8785026b149797ecc0758be3dc3a857d405f2f62074ef30',
            "type": 'customer.created',
            "created_at": '2019-08-24T14:15:22Z',
            "data": {
              "id": 'string',
              "object": {
                "customer": {
                  "id": 'CST_AQmxh4y_QGoNNIG5NUw0jttqyYedL1LklACQdyJ3H-Vs6WmLtP6A_C7XjQNohvY',
                  "cashtag": 'string',
                  "reference_id": 'CUST_123'
                }
              },
              "type": 'customer'
            }
          },
          "api_version": 'string'
        }
      end

      def make_api_key_list
        { "webhook_events": [webhook_event], "cursor": 'Cgl0dmNqa3R4MHk=' }
      end

      module_function :make_api_key_list
    end

    # API

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

      def customer_request_headers(client_id = CLIENT_ID)
        {
          'Accept' => 'application/json',
          'Authorization' => "Client #{client_id}",
          'Content-Type' => 'application/json'
        }
      end

      module_function :network_api_headers, :customer_request_headers
    end
  end
end
