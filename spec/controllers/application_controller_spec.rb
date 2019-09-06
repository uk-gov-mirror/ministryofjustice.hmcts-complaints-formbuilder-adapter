require 'rails_helper'

describe ApplicationController, type: :controller do
  describe '#authorize_request requires body to be json web encrypted' do
    # test controller to test ApplicationController logic
    controller(ApplicationController) do
      def create
        render json: decrypted_body, status: :ok
      end
    end

    context 'and rejects them if not' do
      it 'a body' do
        post :create
        expect(response).to have_http_status(401)
      end

      it 'a unencrypted payload' do
        post :create, body: { 'something': true }.to_json
        expect(response).to have_http_status(401)
      end

      it 'a encrypted with the incorrect key' do
        post :create, body: encrypted_body
        expect(response).to have_http_status(401)
      end
    end

    context 'and accepts them' do
      let(:test_key) { [243, 130, 191, 163, 8, 63, 98, 223, 78, 71, 61, 254, 24, 23, 166, 41].pack('c*') }

      it 'when a valid body is given' do
        msg = { bar: 'foo' }.to_json
        post :create, body: encrypted_body(key: test_key, msg: msg)
        expect(response).to have_http_status(200)
        expect(response.body).to eq(msg)
      end
    end

    def encrypted_body(key: SecureRandom.random_bytes(16), msg: { msg: 'foo' }.to_json)
      JWE.encrypt(msg, key, alg: 'dir')
    end
  end
end
