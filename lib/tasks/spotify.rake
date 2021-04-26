namespace :spotify do
  desc "Calls for all_users_currently_playing job"
  task fetch_players: :environment do
    AllUsersCurrentlyPlayingJob.perform_now
  end
end
