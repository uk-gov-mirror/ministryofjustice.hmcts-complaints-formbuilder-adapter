module AuthHelper
  def test_key
    [243, 130, 191, 163, 8, 63, 98, 223, 78, 71, 61, 254, 24, 23, 166, 41].pack('c*').freeze
  end


  def encrypted_body(key: test_key, msg: { msg: 'foo' }.to_json)
    JWE.encrypt(msg, key, alg: 'dir')
  end
end
