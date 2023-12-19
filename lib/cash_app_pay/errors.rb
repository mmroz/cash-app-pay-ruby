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
end
