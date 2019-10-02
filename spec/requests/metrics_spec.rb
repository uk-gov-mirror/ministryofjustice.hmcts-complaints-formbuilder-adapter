require 'rails_helper'

describe 'Delayed Job Metrics', type: :request do
  before do
    ENV['METRICS_AUTH_USERNAME'] = 'dhh'
    ENV['METRICS_AUTH_PASSWORD'] = 'secret'
  end

  context 'when unauthenticated' do
    before do
      get '/metrics'
    end

    it 'denies access' do
      expect(response.body).to eq("HTTP Basic: Access denied.\n")
    end
  end

  context 'when authenticated' do
    let(:auth_headers) do
      {
        'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials('dhh', 'secret')
      }
    end

    let(:job) { Delayed::Job.create!(handler: '{}') }

    context 'when there are successful jobs' do
      before do
        ProcessedSubmission.create!
        get '/metrics', headers: auth_headers
      end

      it 'shows pending jobs' do
        expected_result = '# TYPE delayed_jobs_successful gauge
# HELP delayed_jobs_successful Number of successful jobs
delayed_jobs_successful 1'
        expect(response.body).to include(expected_result)
      end
    end

    context 'when there are pending jobs' do
      before do
        job.update(attempts: 0)
        get '/metrics', headers: auth_headers
      end

      it 'shows pending jobs' do
        expected_result = '# TYPE delayed_jobs_pending gauge
# HELP delayed_jobs_pending Number of pending jobs
delayed_jobs_pending 1'
        expect(response.body).to include(expected_result)
      end
    end

    context 'when there are failed jobs' do
      before do
        job.update(attempts: 1)
        get '/metrics', headers: auth_headers
      end

      it 'shows failed jobs' do
        expected_result = '# TYPE delayed_jobs_failed gauge
# HELP delayed_jobs_failed Number of jobs failed
delayed_jobs_failed 1'

        expect(response.body).to include(expected_result)
      end
    end

    describe 'Response headers' do
      before { get '/metrics', headers: auth_headers }

      it 'adds the prometheus version' do
        expect(response.headers['Content-Type']).to eq('text/plain; version=0.0.4')
      end
    end
  end
end
