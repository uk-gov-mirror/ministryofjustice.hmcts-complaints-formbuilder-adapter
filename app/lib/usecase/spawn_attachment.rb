module Usecase
  class SpawnAttachment
    def initialize(klass: Attachment, params: params)
      @klass = klass
      @params = params
    end

    def call
      new_attachment.save
    end

    private

    attr_reader :klass, :params

    def new_attachment
      @new_attachment ||= klass.new(params)
    end
  end
end
