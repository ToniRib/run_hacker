require "rails_helper"

RSpec.feature "Guest tries to visit unauthorized pages" do
  scenario "tries to visit dashboard" do
    visit dashboard_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Must be logged in to view that page")
  end

  scenario "tries to visit temperature" do
    visit temperature_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Must be logged in to view that page")
  end

  scenario "tries to visit time of day" do
    visit time_of_day_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Must be logged in to view that page")
  end

  scenario "tries to visit location" do
    visit location_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Must be logged in to view that page")
  end

  scenario "tries to visit season" do
    visit season_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Must be logged in to view that page")
  end

  scenario "tries to visit elevation" do
    visit elevation_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Must be logged in to view that page")
  end

  scenario "tries to visit workouts" do
    visit workouts_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Must be logged in to view that page")
  end

  scenario "tries to visit specific workout" do
    workout = create(:workout)

    visit workout_path(workout)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Must be logged in to view that page")
  end
end
