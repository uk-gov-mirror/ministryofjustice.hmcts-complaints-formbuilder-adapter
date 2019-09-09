RSpec.configure do |rspec|
  # This config option will be enabled by default on RSpec 4,
  # but for reasons of backwards compatibility, you have to
  # set it on RSpec 3.
  #
  # It causes the host group and examples to inherit metadata
  # from the shared context.
  rspec.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec.shared_context 'when authentication required', when_authentication_required: :metadata do
  # before { @some_var = :some_value }
  # def shared_method
  #   "it works"
  # end
  let(:url) { raise "set the url to test auth vs ie. 'let(:url) { '/v1/complaint'}' " }

  it 'requires authentication' do
    post url
    expect(response).to have_http_status(:unauthorized)
  end
end
