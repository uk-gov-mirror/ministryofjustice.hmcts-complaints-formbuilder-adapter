require 'rails_helper'

describe ComplaintController, type: :controller do
  it { expect(post: 'v1/complaint').to be_routable }

  it 'returns 201 on any post' do
    post :create, body: encrypted_body
    expect(response).to have_http_status(201)
  end
end
