class UserAggregatesSerializer < ActiveModel::Serializer
  attributes :total_workouts, :total_distance, :total_time,
             :total_calories, :date_joined

  def total_workouts
    object.workouts.count
  end

  def total_distance
    object.workouts.total_distance_in_miles
  end

  def total_time
    object.workouts.total_time_in_minutes
  end

  def total_calories
    object.workouts.total_calories_in_kcal
  end

  def date_joined
    object.date_joined_formatted
  end
end
