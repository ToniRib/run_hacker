class Presenters::DashboardPresenter < SimpleDelegator
  def initialize(model)
    super(model)
  end

  def total_distance_in_miles
    (workouts.sum(:distance) / 1609.344).round(2)
  end

  def average_distance_in_miles
    (total_distance_in_miles / number_of_workouts).round(2)
  end

  def total_time_in_hours
    (workouts.sum(:elapsed_time) / 3600).round(2)
  end

  def total_calories_in_kcal
    (workouts.sum(:metabolic_energy) / 4184).round(0)
  end
end
