module AuthHelper
  def test_key
    Rails.application.config.auth.fetch(:shared_key)
  end

  def encrypted_body(key: test_key, msg: { msg: 'foo' }.to_json)
    JWE.encrypt(msg, key, alg: 'dir')
  end
end
