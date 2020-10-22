module Dirigible
  # @private
  module Connection
    private
    def connection
      options = { ssl: { min_version: OpenSSL::SSL::TLS1_2_VERSION, verify: true }, proxy: proxy }
      Faraday.new(endpoint, options) do |faraday|
        logger.info(faraday.ssl)
        faraday.request(:json)
        faraday.basic_auth(app_key, master_secret)
        faraday.adapter(http_adapter)
      end
    end

    def logger
      @logger ||= Sidekiq::Logging.logger
    end
  end
end
