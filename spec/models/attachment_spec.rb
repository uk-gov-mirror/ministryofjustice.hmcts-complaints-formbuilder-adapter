require 'rails_helper'

RSpec.describe Attachment do
  describe '#save' do
    let(:params) do
      {
        url: 'https://www.example.com/image.png',
        encryption_key: 'some_encryption_key',
        encryption_iv: 'some_encryption_iv'
      }
    end

    subject do
      described_class.new(params)
    end

    it 'saves a valid record' do
      expect { subject.save }.to change(Attachment, :count).by(1)
    end

    it 'generates identifier' do
      expect(subject.identifier).to be_nil
      subject.save
      expect(subject.identifier).to_not be_nil
    end
  end
end
