# frozen_string_literal: true

module CashAppPay
  class Grant < APIResource

    def self.resource_url
      raise NotImplementedError, 'Grant does not have a resource_url'
    end

    def self.object_name
      :grant
    end
  end
end
