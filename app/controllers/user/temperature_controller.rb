class User::TemperatureController < User::BaseController
  def index
    @workouts = Rails.cache.fetch(cache_name) do
      current_user.workouts
    end
  end

  private

  def cache_name
    "workout-temperature-listing-#{current_user.workouts.count}" \
    "-#{current_user.workouts.maximum(:updated_at)}-#{current_user.id}"
  end
end
