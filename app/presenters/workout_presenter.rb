class WorkoutPresenter < SimpleDelegator
  def initialize(model)
    super(model)
  end

  def display_temperature
    temperature ? "#{temperature} °F" : not_available
  end

  def starting_time_only
    starting_datetime.in_time_zone(local_timezone).strftime("%l:%M %P")
  end

  def display_elapsed_time
    elapsed_time ? "#{elapsed_time_in_minutes} minutes" : not_available
  end

  def display_calories_burned
    metabolic_energy ? "#{calories_burned_in_kcal} kcal" : not_available
  end

  def display_average_speed
    average_speed ? "#{average_speed_in_mph} mph" : not_available
  end

  private

  def not_available
    "Not Available"
  end
end
