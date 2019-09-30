require 'rails_helper'

describe ProcessedSubmission do
  context 'when there are no processed submissions' do
    it 'returns 0' do
      expect(described_class.count).to eq(0)
    end
  end
end
