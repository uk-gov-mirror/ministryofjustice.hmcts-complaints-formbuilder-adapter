class ApplicationController < ActionController::API
  before_action :authorize_request
  attr_reader :decrypted_body

  def authorize_request
    encrypted_payload = request.raw_post
    return render_unauthorized if encrypted_payload.empty?

    begin
      @decrypted_body = JWE.decrypt(encrypted_payload, [243, 130, 191, 163, 8, 63, 98, 223, 78, 71, 61, 254, 24, 23, 166, 41].pack('c*'))
      return
    rescue JWE::DecodeError => e
      logger.info("retuning unauthorized due to JWE::DecodeError '#{e}'")
    rescue JWE::InvalidData => e
      logger.error("retuning unauthorized due to JWE::InvalidData (we could be missing the decryption key) '#{e}'")
    end
    render_unauthorized
  end

  private

  def render_unauthorized
    render status: :unauthorized
  end
end
