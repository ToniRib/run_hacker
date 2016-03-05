require "rails_helper"

RSpec.feature "User views a specific workout" do
  scenario "workout has a timeseries available" do
    user = User.create(user_params)
    map_my_fitness_id = "932453273"
    workout = create(:workout, user: user, map_my_fitness_id: map_my_fitness_id)

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    Rails.cache.clear

    VCR.use_cassette("load_time_series") do
      visit workout_path(workout)
    end

    expect(page).to have_css("#google-map")
    expect(page).to have_content(workout.starting_date_no_time)
    expect(page).to have_content(workout.starting_time_only)
    expect(page).to have_content(workout.location.city_and_state)
    expect(page).to have_content(workout.distance_in_miles)
    expect(page).to have_content(workout.elapsed_time_in_minutes)
    expect(page).to have_content(workout.temperature)
    expect(page).to have_content(workout.calories_burned_in_kcal)
    expect(page).to have_content(workout.average_speed_in_mph)
    expect(page).to have_content("2.49 mph")
    expect(page).to have_content("15.78 mph")
    expect(page).to have_content("3.28 ft")
    expect(page).to have_content("72.6 ft")
  end

  scenario "workout does not have a timeseries available" do
    user = User.create(user_params)
    workout = create(:workout, user: user, has_time_series: false)

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    VCR.use_cassette("workout_with_no_time_series") do
      visit workout_path(workout)
    end

    expect(current_path).to eq(workouts_path)
    expect(page).to have_content("Workout does not have a time series to display")
  end
end
