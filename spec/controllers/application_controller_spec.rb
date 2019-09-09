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
        payload = JWE.encrypt({ msg: 'foo' }.to_json, SecureRandom.random_bytes(16), alg: 'dir')
        post :create, body: payload
        expect(response).to have_http_status(401)
      end
    end

    context 'and accepts them' do
      it 'when a valid body is given' do
        msg = { bar: 'foo' }.to_json
        post :create, body: encrypted_body(msg: msg)
        expect(response).to have_http_status(200)
        expect(response.body).to eq(msg)
      end
    end
  end
end
