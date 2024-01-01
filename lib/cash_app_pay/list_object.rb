# frozen_string_literal: true

module CashAppPay
  class ListObject
    include Enumerable

    attr_accessor :url, :data, :cursor, :opts, :klass, :filters

    def self.initialize_from_response(klass, response, opts, filters, url = nil)
      key = "#{klass.object_name}s".to_sym
      list_data = response.data
      entries = list_data[key]&.map { |entry| klass.new(entry, opts) } || []
      cursor = list_data[:cursor]
      new(klass, entries, cursor, opts, filters, url)
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

      # Calls List on the klass or the URL if one exists.
      # This is a work around for resources that contain dynamic URLs.
      # See CashAppPay::Dispute#list_dispute_evidence
      if url.nil?
        klass.list(params, opts)
      else
        list(params, opts)
      end
    end

    private

    def self.empty_list(klass, opts = {}, cursor = nil, filters = {}, url = nil)
      ListObject.new(url, klass, [], cursor, opts, filters)
    end

    def initialize(klass, data, cursor, opts, filters, url)
      self.klass = klass
      self.data = data
      self.cursor = cursor
      self.opts = opts
      self.filters = filters
      self.url = url
    end

    def list(_params, opts)
      response, opts = klass.execute_resource_request(
        method: :get,
        url: url,
        url_params: filters,
        body_params: nil,
        opts: opts
      )
      ListObject.initialize_from_response(klass, response, opts, filters, url)
    end
  end
end
