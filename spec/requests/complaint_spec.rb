describe 'Submitting a complaint', type: :request do
  include_context 'when authentication required' do
    let(:url) { '/v1/complaint' }
  end

  it 'returns 201 on a valid post' do
    post '/v1/complaint', params: encrypted_body
    expect(response).to have_http_status(:created)
  end
end
