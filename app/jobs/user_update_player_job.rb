class UserUpdatePlayerJob < ApplicationJob
  queue_as :default
  unique :until_executing, on_conflict: :log

  rescue_from ActiveJob::DeserializationError do |exception|
    Rails.logger.error(exception)
  end

  def perform(user)
    PlayerUpdateService.new(user).call
  end
end
