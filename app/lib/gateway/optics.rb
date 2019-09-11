module Gateway
  class Optics
    class ClientError < StandardError; end

    GET_TOKEN_ENDPOINT = 'https://uat.icasework.com/token?db=hmcts'.freeze
    ENDPOINT = 'https://uat.icasework.com/createcase?db=hmcts'.freeze

    def request_bearer_token(jwt_token:)
      rep = post_jwt(jwt_token)
      json = JSON.parse rep.body, symbolize_names: true
      json.fetch(:access_token)
    end

    def post(body:, bearer_token:)
      HTTParty.post(ENDPOINT, headers: headers(bearer_token), body: body)
    end

    private

    def headers(token)
      {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{token}"
      }
    end

    def post_jwt(jwt_token)
      result = HTTParty.post(
        GET_TOKEN_ENDPOINT,
        headers: { 'Content-Type' => 'application/x-www-form-urlencoded' },
        body: URI.encode_www_form(
          grant_type: 'urn:ietf:params:oauth:grant-type:jwt-bearer',
          assertion: jwt_token
        )
      )
      return result if result.success?

      raise ClientError, result
    end
  end
end
