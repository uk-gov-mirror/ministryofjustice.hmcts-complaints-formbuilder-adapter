require 'securerandom'

class Attachment < ApplicationRecord
  before_validation :generate_identifier

  private

  def generate_identifier
    self.identifier ||= SecureRandom.uuid
  end
end
