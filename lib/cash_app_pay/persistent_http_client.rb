# frozen_string_literal: true

module CashAppPay
  class PersistentHttpClient
    class << self
      # url: URI / String
      # options: any options that Net::HTTP.new accepts
      def get(url, options = {})
        uri = url.is_a?(URI) ? url : URI(url)
        connection_manager.get_client(uri, options)
      end

      private

      # each thread gets its own connection manager
      def connection_manager
        # before getting a connection manager
        # we first clear all old ones
        remove_old_managers
        Thread.current[:cash_app_pay_client__internal_use_only] ||= new_manager
      end

      def new_manager
        # create a new connection manager in a thread safe way
        mutex.synchronize do
          manager = ConnectionManager.new
          connection_managers << manager
          manager
        end
      end

      def remove_old_managers
        mutex.synchronize do
          removed = connection_managers.reject!(&:stale?)
          (removed || []).each(&:close_connections!)
        end
      end

      def mutex
        @mutex ||= Mutex.new
      end

      def connection_managers
        @connection_managers ||= []
      end
    end
  end
end
