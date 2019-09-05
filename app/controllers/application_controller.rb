class ApplicationController < ActionController::API

  before_action :authorize_request

  def authorize_request
    encrypted_payload = request.raw_post
    # puts "-> #{encrypted_payload}"
    return render_unauthorized if encrypted_payload.empty?

    begin
    JWE.decrypt(encrypted_payload, 'the-test-secrect')
    rescue JWE::DecodeError => e
      logger.info("retuning unauthorized due to JWE DecodeError '#{e}'")
      return render_unauthorized
    end
  end

  private

  def render_unauthorized
    render status: :unauthorized
  end

end
