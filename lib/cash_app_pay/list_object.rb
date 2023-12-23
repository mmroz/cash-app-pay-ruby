# frozen_string_literal: true

module CashAppPay
  # TODO: - I can make this a sublcass of CashAppPay::APIResource
  class ListObject
    include Enumerable

    attr_accessor :filters
    attr_accessor :data, :cursor, :opts, :klass

    def self.empty_list(klass, opts = {}, cursor = nil, filters = {})
      ListObject.new(klass, [], cursor, opts, filters)
    end

    def initialize(klass, data, cursor, opts, filters)
      self.klass = klass
      self.data = data
      self.cursor = cursor
      self.opts = opts
      self.filters = filters
    end

    def self.initialize_from_response(klass, response, opts, filters)
      debugger
      key = "#{klass.object_name}s".to_sym
      list_data = response.data
      entries = list_data[key].map { |entry| klass.new(entry, opts) }
      cursor = list_data[:cursor]
      new(klass, entries, cursor, opts, filters)
    end

    def inspect
      "#<#{self.class}:0x#{object_id.to_s(16)}> JSON: " +
        JSON.pretty_generate({ filters: filters, data: data, cursor: cursor })
    end

    def [](key)
      data[key]
    end

    def each(&blk)
      data.each(&blk)
    end

    def empty?
      data.empty?
    end

    def auto_paging_each(&blk)
      page = self
      loop do
        page.each(&blk)
        page = page.next_page
        break if page.empty?
      end
    end

    def next_page(params = {}, opts = {})
      return self.class.empty_list(klass, opts, nil, filters) if cursor.nil?

      params = filters.merge(cursor: cursor).merge(params)

      klass.list(params, opts)
    end
  end
end
