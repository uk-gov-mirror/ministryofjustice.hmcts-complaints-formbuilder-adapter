require 'rails_helper'

RSpec.describe Usecase::SpawnAttachments do
  let(:form_builder_payload) do
    {
      submissionAnswers: {},
      attachments: [
        {
          url: 'https://www.example.com/image.png',
          encryption_key: 'some_encryption_key',
          encryption_iv: 'some_encryption_iv'
        },
        {
          url: 'https://www.example.com/document.pdf',
          encryption_key: 'some_encryption_key',
          encryption_iv: 'some_encryption_iv'
        }
      ]
    }
  end

  describe '#execute' do
    subject(:spawn_attachments) do
      described_class.new(form_builder_payload: form_builder_payload)
    end

    let(:spawn_attachment) { instance_double('Usecase::SpawnAttachment', call: true) }

    it 'creates an attachment record with correct params' do
      allow(Usecase::SpawnAttachment).to receive(:new).twice.and_return(spawn_attachment)

      spawn_attachments.call

      expect(Usecase::SpawnAttachment).to have_received(:new).twice
    end
  end
end
