# frozen_string_literal: true

module CashAppPay
  class APIResource < CashAppPayObject
    include CashAppPay::APIOperations::Request

    attr_reader :opts, :errors

    def initialize(values = {}, opts = {})
      super(values)
      @opts = opts
      @errors = []
    end

    def self.resource_url
      raise NotImplementedError, 'Api Resource is an abstract class'
    end

    # def refresh
    #   resp, opts = self.class.execute_resource_request(method: :get, url: resource_url, opts: @opts)
    #   initialize_from(resp.data, opts)
    # end

    # def self.retrieve(id, opts = {})
    #   instance = new({ id: id }, opts)
    #   instance.refresh
    #   instance
    # end

    def request_cash_app_pay_object(method:, path:, params:, opts: {})
      body = self.class.encode_body(params) unless params.nil?
      response, opts = execute_resource_request(method: method, url: path, body_params: body, opts: opts)
      initialize_from(response.data, opts)
    end

    private

    def self.initialize_from_net_response(response, opts)
      instance = new
      instance.send(:initialize_from, response.data, opts)
      instance
    end

    def initialize_from(values, opts)
      @errors = values.fetch(:errors, [])
      @values = values.fetch(self.class.object_name, {})
      @opts = opts
      self
    end

    def resource_url
      unless (id = self.id)
        raise InvalidRequestError.new(
          "Could not determine which URL to request: #{self.class} instance has invalid ID: #{id.inspect}",
          'id'
        )
      end
      "#{self.class.resource_url}/#{CGI.escape(id)}"
    end

    # Encode the params for the body of the request.
    # If the params contains `idempotency_key` then put this at the root
    # e.g. { request: { id: 1 }, idempotency_key: 'key' }
    # params: Hash of params
    def self.encode_body(params)
      idempotency_key = params.delete(:idempotency_key) || params.delete('idempotency_key')
      body = Hash[object_name, params]
      body[:idempotency_key] = idempotency_key unless idempotency_key.nil?
      body.to_json
    end
  end
end
