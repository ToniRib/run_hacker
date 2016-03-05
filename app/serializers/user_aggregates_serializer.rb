class UserAggregatesSerializer < ActiveModel::Serializer
  attributes :total_workouts, :total_distance, :total_time,
             :total_calories, :average_run_distance

  def total_workouts
    object.count
  end

  def total_distance
    object.total_distance_in_miles
  end

  def total_time
    object.total_time_in_hours
  end

  def total_calories
    object.total_calories_in_kcal
  end

  def average_run_distance
    object.average_distance_in_miles
  end
end
