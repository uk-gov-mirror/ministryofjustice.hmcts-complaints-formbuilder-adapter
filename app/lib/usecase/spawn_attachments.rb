module Usecase
  class SpawnAttachments
    def initialize(form_builder_payload:)
      @form_builder_payload = form_builder_payload
    end

    def call
      attachments.map do |attachment|
        usecase = SpawnAttachment.new(params: attachment)
        usecase.call
      end
    end

    private

    attr_reader :form_builder_payload

    def attachments
      form_builder_payload.fetch(:attachments)
    end
  end
end
