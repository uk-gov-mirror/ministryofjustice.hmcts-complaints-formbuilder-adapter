require 'rails_helper'

describe 'Downloading an attachment', type: :request do
  it 'returns 201 on a valid post' do
    get '/v1/attachments/attachment_id'

    expect(response).to have_http_status(:ok)
  end
end
