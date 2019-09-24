require 'rails_helper'

RSpec.describe Usecase::DownloadAttachment do
  let(:identifier) { 'some-attachment-guid' }

  describe '#call' do
    subject(:download_attachment) { described_class.new(identifier: identifier) }

    let(:attachment_double) { instance_double(Attachment, url: 'https://example.com.com/hello.txt') }

    before do
      stub_request(:get, 'https://example.com.com/hello.txt')
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Host' => 'example.com.com',
            'User-Agent' => 'Ruby'
          }
        )
        .to_return(status: 200, body: file_fixture('hello.txt').read, headers: {})
    end

    it 'returns downloaded file' do
      allow(Attachment).to receive(:find_by).with(identifier: identifier).and_return(attachment_double)

      expect(download_attachment.call).to eql("hello world\n")
    end
  end
end
