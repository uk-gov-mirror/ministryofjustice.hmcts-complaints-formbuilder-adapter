require 'raven'
require_relative '../lib/sentry_job_argument_scrubber'

describe SentryJobArgumentScrubber do
  let(:job_data) do
    {
      extra: {
        delayed_job: ['something sensitive'],
        active_job: ['something sensitive too']
      }
    }
  end

  it 'masks job arguments' do
    expect(described_class.new.process(job_data)).to eq(
      extra: { active_job: '********', delayed_job: '********' }
    )
  end

  it 'returns the original data for non job errors' do
    data = { extra: { foo: ['bar'] } }

    expect(described_class.new.process(data)).to eq(extra: { foo: ['bar'] })
  end
end
