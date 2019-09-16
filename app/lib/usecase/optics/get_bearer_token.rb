module Usecase
  module Optics
    class GetBearerToken
      def initialize(optics_gateway:, generate_jwt_token:)
        @optics_gateway = optics_gateway
        @generate_jwt_token = generate_jwt_token
      end

      def execute
        optics_gateway.request_bearer_token(
          jwt_token: generate_jwt_token.execute
        )
      end

      private

      attr_reader :optics_gateway, :generate_jwt_token
    end
  end
end
