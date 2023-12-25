# frozen_string_literal: true

module CashAppPay
  class APIResource < CashAppPayObject
    include CashAppPay::APIOperations::Request

    attr_reader :opts

    def initialize(values = {}, opts = {})
      super(values)
      @opts = opts
    end

    def self.resource_url
      raise NotImplementedError, 'API Resource is an abstract class'
    end

    private

    def self.initialize_from_net_response(response, opts)
      instance = new
      instance.send(:initialize_from, response.data, opts)
      instance
    end

    def initialize_from(values, opts)
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
      body = if params.empty? && !idempotency_key.nil?
               { idempotency_key: idempotency_key }
             else
               named_body_params = Hash[object_name, params]
               named_body_params[:idempotency_key] = idempotency_key unless idempotency_key.nil?
               named_body_params
             end
      body.to_json
    end
  end
end
