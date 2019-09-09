namespace :auth do
  desc 'run locally to generate a key for use as the shared secret'
  task :generate_key do
    puts 'Use this key by setting it as a the value for DEVELOPMENT_JWE_SHARED_KEY or PRODUCTION_JWE_SHARED_KEY env vars'
    puts
    puts Base64.encode64 SecureRandom.random_bytes(16)
  end
end
