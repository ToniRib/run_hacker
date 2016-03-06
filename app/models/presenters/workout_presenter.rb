class Presenters::WorkoutPresenter < SimpleDelegator
  def initialize(model)
    super(model)
  end

  def display_starting_date_no_time
    location ? starting_date_no_time : ""
  end

  def display_distance_in_miles
    distance ? distance_in_miles : ""
  end

  def display_average_speed_in_mph
    average_speed ? average_speed_in_mph : ""
  end

  def display_elapsed_time_in_minutes
    elapsed_time ? elapsed_time_in_minutes : ""
  end

  def display_calories_burned_in_kcal
    metabolic_energy ? calories_burned_in_kcal : ""
  end

  def display_city_and_state
    location ? location.city_and_state : ""
  end

  def display_elevation_in_feet
    route_and_elevation_exist ? route.elevation_in_feet : ""
  end

  private

  def route_and_elevation_exist
    route && route.elevation
  end
end
