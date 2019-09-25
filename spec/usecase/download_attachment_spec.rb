require 'rails_helper'

RSpec.describe Usecase::DownloadAttachment do
  let(:identifier) { 'some-attachment-guid' }

  describe '#call' do
    subject(:download_attachment) { described_class.new(identifier: identifier) }

    let(:attachment_double) { instance_double(Attachment, url: 'https://example.com/hello.txt') }

    before do
      stub_request(:get, 'https://example.com/hello.txt')
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent' => 'Ruby'
          }
        )
        .to_return(status: 200, body: file_fixture('hello.txt').read, headers: {})
    end

    it 'returns downloaded file' do
      allow(Attachment).to receive(:find_by).with(identifier: identifier).and_return(attachment_double)

      expect(download_attachment.call).to eql("hello world\n")
    end

    context 'when there is an error' do
      before do
        stub_request(:get, 'https://example.com/hello.txt')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 500, body: '', headers: {})
      end

      it 'raises an error' do
        allow(Attachment).to receive(:find_by).with(identifier: identifier).and_return(attachment_double)

        expect { download_attachment.call }.to raise_error(Usecase::DownloadAttachment::ClientError)
      end
    end
  end
end
