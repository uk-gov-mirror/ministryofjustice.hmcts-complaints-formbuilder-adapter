require 'rails_helper'

describe ComplaintController, type: :controller do
  it { expect(post: "/complaint").to be_routable }

  it 'returns 200 on any post' do
    post :create, body: {}
    expect(response).to have_http_status(200)
  end
end
