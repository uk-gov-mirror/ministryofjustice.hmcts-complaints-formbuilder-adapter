require 'net/http'

module Usecase
  class DownloadAttachment
    def initialize(identifier:)
      @identifier = identifier
    end

    def call
      Net::HTTP.get(uri)
    end

    private

    attr_reader :identifier

    def attachment
      @attachment ||= Attachment.find_by(identifier: identifier)
    end

    def uri
      URI(attachment.url)
    end
  end
end
