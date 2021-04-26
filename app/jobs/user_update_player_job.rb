class UserUpdatePlayerJob < ApplicationJob
  queue_as :default
  unique :until_executing, on_conflict: :log

  def perform(user)
    PlayerUpdateService.new(user).call
  end
end
