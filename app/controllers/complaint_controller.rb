class ComplaintController < ApplicationController
  def create
    Usecase::Optics::CreateCase.new(
      optics_gateway: Gateway::Optics.new,
      presenter: Presenter::Complaint.new(form_builder_payload: @decrypted_body),
      get_bearer_token: bearer_token
    ).execute

    render json: { placeholder: true }, status: 201
  end

  private

  def bearer_token
    Usecase::Optics::GetBearerToken.new(
      optics_gateway: Gateway::Optics.new,
      generate_jwt_token: Usecase::Optics::GenerateJwtToken.new(
        url: 'https://uat.icasework.com/token?db=hmcts',
        api_key: ENV.fetch('OPTICS_API_KEY'),
        hmac_secret: ENV.fetch('OPTICS_SECRET_KEY')
      )
    )
  end
end
