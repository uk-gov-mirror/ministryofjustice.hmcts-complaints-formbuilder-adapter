module Usecase
  class SpawnAttachments
    def initialize(form_builder_payload:)
      @form_builder_payload = form_builder_payload
    end

    def call
      form_builder_payload.dig(:submissionAnswers, :attachments).each do |attachment|
        usecase = Usecase::SpawnAttachment.new(params: attachment)
        usecase.call
      end
    end

    private

    attr_reader :form_builder_payload
  end
end
