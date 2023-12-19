# frozen_string_literal: true

# connection manager represents
# a cache of all keep-alive connections
# in a current thread
module CashAppPay
  class ConnectionManager
    DEFAULT_OPTIONS = { read_timeout: 80, open_timeout: 30 }.freeze
    # if a client wasn't used within this time range
    # it gets removed from the cache and the connection closed.
    # This helps to make sure there are no memory leaks.
    STALE_AFTER = 60 * 5 # 5.minutes

    # Seconds to reuse the connection of the previous request. If the idle time is less than this Keep-Alive Timeout, Net::HTTP reuses the TCP/IP socket used by the previous communication. Source: Ruby docs
    KEEP_ALIVE_TIMEOUT = 30 # seconds

    # KEEP_ALIVE_TIMEOUT vs STALE_AFTER
    # STALE_AFTER - how long an Net::HTTP client object is cached in ruby
    # KEEP_ALIVE_TIMEOUT - how long that client keeps TCP/IP socket open.

    attr_accessor :clients_store, :last_used

    def initialize
      self.clients_store = {}
      self.last_used = Time.now
    end

    def get_client(uri, options)
      mutex.synchronize do
        # refresh the last time a client was used,
        # this prevents the client from becoming stale
        self.last_used = Time.now

        # we use params as a cache key for clients.
        # 2 connections to the same host but with different
        # options are going to use different HTTP clients
        params = [uri.host, uri.port, options]
        client = clients_store[params]

        return client if client

        client = Net::HTTP.new(uri.host, uri.port)
        client.keep_alive_timeout = KEEP_ALIVE_TIMEOUT

        # set SSL to true if a scheme is https
        client.use_ssl = uri.scheme == 'https'

        # dynamically set Net::HTTP options
        DEFAULT_OPTIONS.merge(options).each_pair do |key, value|
          client.public_send("#{key}=", value)
        end

        # open connection
        client.start

        # cache the client
        clients_store[params] = client

        client
      end
    end

    # close connections for each client
    def close_connections!
      mutex.synchronize do
        clients_store.each_value(&:finish)
        self.clients_store = {}
      end
    end

    def stale?
      Time.now - last_used > STALE_AFTER
    end

    def mutex
      @mutex ||= Mutex.new
    end
  end
end
