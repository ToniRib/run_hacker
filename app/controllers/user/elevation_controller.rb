class User::ElevationController < User::BaseController
  def index
    @workouts = Rails.cache.fetch(cache_name) do
      current_user.workouts.includes(:route)
    end
  end

  private

  def cache_name
    "workout-elevation-listing-#{current_user.workouts.count}" \
    "-#{current_user.workouts.maximum(:updated_at)}-" \
    "#{current_user.routes.maximum(:updated_at)}-#{current_user.id}"
  end
end
