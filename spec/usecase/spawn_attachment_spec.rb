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
    subject(:spawn_attachment) { described_class.new(params: attachment_hash) }

    let(:attachment_double) { instance_double('Attachment', save: true) }

    it 'calls save on respository' do
      allow(Attachment).to receive(:new).with(attachment_hash).and_return(attachment_double)

      spawn_attachment.call

      expect(attachment_double).to have_received(:save)
    end
  end
end
