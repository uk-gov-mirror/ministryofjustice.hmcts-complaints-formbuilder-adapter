class SendComplaintJob < ApplicationJob
  queue_as :send_complaints

  def perform(form_builder_payload:)
    Rails.logger.info("Working on job_id: #{job_id}")

    attachments = Usecase::SpawnAttachments.new(form_builder_payload: form_builder_payload).call

    Usecase::Optics::CreateCase.new(
      optics_gateway: gateway,
      presenter: Presenter::Complaint.new(form_builder_payload: form_builder_payload,
                                          attachments: attachments),
      get_bearer_token: bearer_token
    ).execute

    raise 'Testing Sentry'
    record_successful_submission
  end

  private

  def bearer_token
    Usecase::Optics::GetBearerToken.new(
      optics_gateway: gateway,
      generate_jwt_token: generate_token
    )
  end

  def generate_token
    Usecase::Optics::GenerateJwtToken.new(
      endpoint: Rails.configuration.x.optics.endpoint,
      api_key: Rails.configuration.x.optics.api_key,
      hmac_secret: Rails.configuration.x.optics.secret_key
    )
  end

  def gateway
    Gateway::Optics.new(endpoint: Rails.configuration.x.optics.endpoint)
  end

  def record_successful_submission
    ProcessedSubmission.create
  end
end
