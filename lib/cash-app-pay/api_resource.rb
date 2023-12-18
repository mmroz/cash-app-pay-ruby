# frozen_string_literal: true

module CashAppPay
  class APIResource < CashAppPayObject
    include CashAppPay::APIOperations::Request::ClassMethods

    attr_reader :opts, :errors

    def initialize(values = {}, opts = {})
      super(values)
      @opts = opts
      @errors = []
    end

    def self.resource_url
      raise NotImplementedError, 'Api Resource is an abstract class'
    end

    def refresh
      resp, opts = execute_resource_request(:get, resource_url, nil, @opts)
      initialize_from(resp.data, opts)
    end

    def self.retrieve(id, opts = {})
      instance = new({ id: id }, opts)
      instance.refresh
      instance
    end

    # TODO: - move to private?
    def request_cash_app_pay_object(method:, path:, params:, opts: {})
      body = params.to_json unless params.nil?
      execute_resource_request(method, path, body, opts)
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

    def self.resource_parameters(params)
      Hash[object_name, params]
    end
  end
end
