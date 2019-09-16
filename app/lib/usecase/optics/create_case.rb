module Usecase
  module Optics
    class CreateCase
      def initialize(optics_gateway:, presenter:, get_bearer_token:)
        @optics_gateway = optics_gateway
        @presenter = presenter
        @get_bearer_token = get_bearer_token
      end

      def execute
        @optics_gateway.post(
          body: @presenter.present,
          bearer_token: @get_bearer_token.execute
        )
      end
    end
  end
end
