require 'rails_helper'

RSpec.describe Usecase::SpawnAttachments do
  let(:form_builder_payload) do
    {
      submissionAnswers: {
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
    }
  end

  describe '#execute' do
    subject do
      described_class.new(form_builder_payload: form_builder_payload)
    end

    it 'creates an attachment record with correct params' do
      expect(Usecase::SpawnAttachment).to receive(:new).twice.and_call_original

      subject.call
    end
  end
end
