class User::TimeOfDayController < User::BaseController
  def index
    @workouts = Rails.cache.fetch(cache_name) do
      current_user.workouts.includes(:route, :location)
    end
  end

  private

  def cache_name
    "workout-time-of-day-listing-#{current_user.workouts.count}" \
    "-#{current_user.workouts.maximum(:updated_at)}-" \
    "#{current_user.locations.maximum(:updated_at)}-#{current_user.id}"
  end
end
