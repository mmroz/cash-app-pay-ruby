# frozen_string_literal: true

module CashAppPay
  class CashAppPayObject
    using CashAppPay::Helpers::Symbolize

    attr_accessor :values

    def initialize(values)
      @values = values.deep_symbolize_keys
      # TODO: - probably remove this since its always a symbol
      @key_class = @values.empty? ? Symbol : @values.keys[0].class
      self.class.assert_valid_key_class(@key_class)
    end

    def to_h(*_args)
      @values
    end

    alias to_hash to_h
    alias as_json to_h

    def to_json(*_args)
      @values.to_json
    end

    def to_s(*_args)
      JSON.pretty_generate(to_h)
    end

    def inspect
      id_string = respond_to?(:id) && !id.nil? ? " id=#{id}" : ''
      "#<#{self.class}:0x#{object_id.to_s(16)}#{id_string}> JSON: " +
        JSON.pretty_generate(@values)
    end

    def [](name)
      data = @values[typed_key(name)]
      if data.is_a?(Hash)
        CashAppPay::CashAppPayObject.new(data)
      elsif data.is_a?(Array)
        data.map do |item|
          item.is_a?(Hash) ? CashAppPay::CashAppPayObject.new(item) : item
        end
      else
        data
      end
    end

    def ==(other)
      if other.is_a?(CashAppPay::CashAppPayObject)
        @values == other.values
      else
        false
      end
    end

    def []=(name, value)
      @values[typed_key(name)] = value
    end

    def method_missing(name, *_args)
      if name.to_s.end_with?('=')
        attr = name.to_s[0...-1].to_sym
        val = _args.first
        self[attr] = val
      else
        self[name]
      end
    end

    def typed_key(key)
      @key_class == String ? key.to_s : key.to_sym
    end

    def self.assert_valid_key_class(key_class)
      return if valid_key_classes.include?(key_class)

      raise "Invalid key_class #{key_class} must be one of #{valid_key_classes.join(' ')}"
    end

    def self.valid_key_classes
      [String, Symbol]
    end
  end
end
