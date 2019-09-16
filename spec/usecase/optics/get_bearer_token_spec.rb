describe Usecase::Optics::GetBearerToken do
  subject(:usecase) do
    described_class.new(
      optics_gateway: optics_gateway,
      generate_jwt_token: generate_jwt_token
    )
  end

  let(:token) { 'some token' }
  let(:generate_jwt_token) { instance_double('Usecase::Optics::GenerateJwtToken') }
  let(:optics_gateway) { instance_double('Gateway::Optics') }

  before do
    allow(generate_jwt_token).to receive(:execute).and_return(token)
    allow(optics_gateway).to receive(:request_bearer_token)
    usecase.execute
  end

  it 'generates a jwt token' do
    expect(generate_jwt_token).to have_received(:execute)
  end

  it 'requests a bearer token with the generated jwt token' do
    expect(optics_gateway).to have_received(:request_bearer_token).with(jwt_token: token)
  end
end
