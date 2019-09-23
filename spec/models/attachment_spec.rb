require 'rails_helper'

RSpec.describe Attachment do
  describe '#save' do
    subject(:attachment) do
      described_class.new(params)
    end

    let(:params) do
      {
        url: 'https://www.example.com/image.png',
        encryption_key: 'some_encryption_key',
        encryption_iv: 'some_encryption_iv'
      }
    end

    it 'saves a valid record' do
      expect { attachment.save }.to change(described_class, :count).by(1)
    end

    it 'generates identifier' do
      expect { attachment.save }.to change { attachment.identifier.nil? }.from(true).to(false)
    end
  end
end
