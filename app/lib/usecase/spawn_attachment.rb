module Usecase
  class SpawnAttachment
    def initialize(params:)
      @params = params
    end

    def call
      new_attachment.save
    end

    private

    attr_reader :params

    def new_attachment
      @new_attachment ||= Attachment.new(params)
    end
  end
end
