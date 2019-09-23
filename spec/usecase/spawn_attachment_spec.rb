require 'rails_helper'

RSpec.describe Usecase::SpawnAttachment do
  let(:attachment_hash) do
    {
      url: 'https://www.example.com/image.png',
      encryption_key: 'some_encryption_key',
      encryption_iv: 'some_encryption_iv'
    }
  end

  describe '#call' do
    let(:attachment_double) { double('attachment') }

    subject { described_class.new(params: attachment_hash) }

    it 'calls save on respository' do
      allow(Attachment).to receive(:new).with(attachment_hash).and_return(attachment_double)
      expect(attachment_double).to receive(:save)

      subject.call
    end
  end
end
