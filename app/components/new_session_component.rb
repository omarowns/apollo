# frozen_string_literal: true

class NewSessionComponent < ViewComponent::Base

  def open_registration?
    ENV.fetch('OPEN_REGISTRATION') { false }
  end
end
