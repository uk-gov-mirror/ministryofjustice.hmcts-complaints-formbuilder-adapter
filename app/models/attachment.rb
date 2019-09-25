require 'securerandom'

class Attachment < ApplicationRecord
  include Rails.application.routes.url_helpers

  after_initialize :generate_identifier

  def exposed_url
    attachment_url(id: identifier)
  end

  private

  def generate_identifier
    self.identifier ||= SecureRandom.uuid
  end
end
