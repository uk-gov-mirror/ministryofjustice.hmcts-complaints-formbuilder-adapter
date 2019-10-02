Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # default async active job backend, uses an in-process thread pool
  config.active_job.queue_adapter = ActiveJob::QueueAdapters::AsyncAdapter.new(
    min_threads: 1,
    max_threads: 2 * Concurrent.processor_count,
    idletime: 600.seconds
  )

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.shared_key = ENV.fetch('DEVELOPMENT_JWE_SHARED_KEY', '5d6dc7fc083ea4f0'.freeze)
  config.x.optics.secret_key = ENV.fetch('OPTICS_SECRET_KEY', SecureRandom.hex(8).freeze)
  config.x.optics.api_key = ENV.fetch('OPTICS_API_KEY', SecureRandom.hex(8).freeze)
  config.x.optics.endpoint = ENV.fetch('OPTICS_ENDPOINT', 'https://uat.icasework.com'.freeze)
  config.x.metrics.password = ENV.fetch('METRICS_AUTH_PASSWORD', 'dhh')
  config.x.metrics.username = ENV.fetch('METRICS_AUTH_USERNAME', 'secret')
end
