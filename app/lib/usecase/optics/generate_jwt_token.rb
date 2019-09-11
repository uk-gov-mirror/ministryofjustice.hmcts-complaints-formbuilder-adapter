module Usecase
  module Optics
    class GenerateJwtToken
      def initialize(url:, api_key:, hmac_secret:)
        @url = url
        @api_key = api_key
        @hmac_secret = hmac_secret
      end

      def execute
        JWT.encode payload, hmac_secret, 'HS256'
      end

      private

      def payload
        {
          iss: api_key,
          aud: url,
          iat: Time.now.to_i,
          exp: Time.now.to_i + ONE_HOUR_IN_SECONDS
        }
      end

      attr_reader :url, :api_key, :hmac_secret
      ONE_HOUR_IN_SECONDS = 3600 * 3600
    end
  end
end
