describe Usecase::Optics::GenerateJwtToken do
  describe '#generate' do
    subject(:token) { described_class.new(url: url, api_key: api_key, hmac_secret: secret_key) }

    let(:jwt_token) { 'eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJmb28iLCJhdWQiOiJleGFtcGxlLmNvbSIsImlhdCI6MTU2ODIxNjA4Nn0.oBZf0cFbUrazmp9YRJ5IFzq3hZdCCkJGGRrFCPu6WNQ' }
    let(:url) { 'example.com' }
    let(:api_key) { 'foo' }
    let(:secret_key) { 'bar' }

    let(:expected_payload) do
      [
        { 'aud' => url,
          'iat' => 1_568_216_086,
          'iss' => 'foo' },
        { 'alg' => 'HS256' }
      ]
    end

    before do
      Timecop.freeze(Time.parse('2019-09-11 15:34:46 +0000'))
    end

    after do
      Timecop.return
    end

    it 'returns the expected jwt token' do
      expect(token.execute).to eq(jwt_token)
    end

    it 'can be decrypted' do
      jwt_decode = JWT.decode(token.execute, secret_key, true, algorithm: 'HS256')
      expect(jwt_decode).to eq(expected_payload)
    end
  end
end
