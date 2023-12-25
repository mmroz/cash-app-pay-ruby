# frozen_string_literal: true

module CashAppPay
  # CashAppPayError is the base error from which all other more specific errors derive.
  class CashAppPayError < StandardError
    attr_reader :message

    def initialize(message)
      @message = message
    end
  end

  # InvalidRequestError is raised when a request is initiated with invalid
  # parameters.
  class InvalidRequestError < CashAppPayError
    attr_accessor :param

    def initialize(message, param)
      super(message)
      @param = param
    end
  end

  # AuthenticationError is raised when invalid credentials are used to connect
  # to Cash App servers.
  class AuthenticationError < CashAppPayError
  end

  class APIError < CashAppPayError
    attr_reader :http_status, :http_body

    def initialize(message, http_status:, http_body:)
      super(message)
      @http_status = http_status
      @http_body = http_body
    end
  end

  class APIResponseError < CashAppPayError
    def initialize(response)
      error_object = ErrorObject.new(response)
      super(error_object.to_s)
    end
  end
end
