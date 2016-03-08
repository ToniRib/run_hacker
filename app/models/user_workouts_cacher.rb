class UserWorkoutsCacher < SimpleDelegator
  def initialize(model)
    super(model)
  end

  def cached_workouts
    Rails.cache.fetch(workout_only_cache_name) { workouts }
  end

  def cached_workouts_with_route
    Rails.cache.fetch(workout_route_cache_name) { workouts.includes(:route) }
  end

  def cached_workouts_with_route_and_location
    Rails.cache.fetch(workout_route_cache_name) do
      workouts.includes(:route, :location)
    end
  end

  def cached_specific_workout(workout_id)
    Rails.cache.fetch(specific_workout_cache_name(workout_id)) do
      workouts.includes(:route, :location).find(workout_id)
    end
  end

  private

  def workout_only_cache_name
    "workout-listing-#{workouts.count}-#{workouts.maximum(:updated_at)}-#{id}"
  end

  def workout_route_cache_name
    "workout-listing-#{workouts.count}-#{workouts.maximum(:updated_at)}" \
    "-#{routes.maximum(:updated_at)}-#{id}"
  end

  def specific_workout_cache_name(workout_id)
    workout = Workout.find(workout_id)
    "workout-specific-#{workout.updated_at}-#{workout.route.updated_at}" \
    "-#{workout.location.updated_at}"
  end
end
