class UserWorkoutsCacher < SimpleDelegator
  def initialize(model)
    super(model)
  end

  def cached_workouts
    Rails.cache.fetch(workout_only_cache_name) { workouts }
  end

  def cached_workouts_with_route
    Rails.cache.fetch(workout_route_cache_name) { workouts }
  end

  def cached_workouts_with_route_and_location
    Rails.cache.fetch(workout_route_location_cache_name) { workouts }
  end

  private

  def workout_only_cache_name
    "workout-listing-#{workouts.count}-#{workouts.maximum(:updated_at)}-#{id}"
  end

  def workout_route_cache_name
    "workout-listing-#{workouts.count}-#{workouts.maximum(:updated_at)}" \
    "-#{routes.maximum(:updated_at)}-#{id}"
  end

  def workout_route_location_cache_name
    "workout-listing-#{workouts.count}-#{workouts.maximum(:updated_at)}" \
    "-#{routes.maximum(:updated_at)}-#{locations.maximum(:updated_at)}-#{id}"
  end
end
