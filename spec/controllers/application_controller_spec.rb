require 'rails_helper'

RSpec.configure do |c|
  c.infer_base_class_for_anonymous_controllers = false
end
describe ApplicationController, type: :controller do
  describe '#authorize_request requires requests to be json web encrypted' do
    # test controller to test ApplicationController logic
    controller(ApplicationController) do
      def create
        render json: { meg: ['if you can see this you must be authorised'] }, status: :ok
      end
    end

    context 'and rejects them if not' do
      it 'a body' do
        post :create
        expect(response).to have_http_status(401)
      end

      it 'a payload that can not be decrypted' do
        post :create, body: 'something'
        expect(response).to have_http_status(401)
      end
    end

    context 'and accepts them' do
      it 'when a valid body is given' do
        # expect(JSON.parse().symbolize_keys).to eql(payload)
        key = 'the-test-secrect'
        encrypted_payload = JWE.encrypt({msg: 'foo'}.to_json, key, alg: 'dir')

        post :create, body: encrypted_payload
        expect(response).to have_http_status(200)
      end
    end
  end
end
