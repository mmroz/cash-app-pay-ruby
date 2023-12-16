# frozen_string_literal: true

module CashAppPay
  class Utils
    def self.params_with_idempotency_key(params)
      duplicate_params = params.dup
      duplicate_params['idempotency_key'] = idempotency_key
      duplicate_params
    end

    def self.idempotency_key
      SecureRandom.uuid
    end
  end
end
