require 'rails_helper'

describe ComplaintController, type: :controller do
  it 'needs to be accessible' do
    route = { post: 'v1/complaint' }
    expect(route).to be_routable
  end

  it 'returns 201 on any post' do
    post :create, body: encrypted_body
    expect(response).to have_http_status(:created)
  end
end
