require "rails_helper"

RSpec.feature "User views elevation graph" do
  scenario "initial load prior to selections" do
    user = create(:user)

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit elevation_path

    expect(page).to have_content("Elevation Analysis")
    expect(page).to have_content("Distance Range")
    expect(page).to have_content("Y-axis")
    expect(page).to have_button("Create Graph")
    expect(page).to have_select("y-axis", options: ["Total Time", "Average Speed", "Time Spent Resting"])
  end

  scenario "user creates Total Time v. Elevation graph", js: true do
    user = create(:user)
    workout1, workout2 = load_workouts(user)

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit elevation_path

    fill_in "minimum_distance", with: "3"
    fill_in "maximum_distance", with: "5"
    click_on "Create Graph"

    expect(page).to have_content("Elevation vs. Total Time for 3 - 5 mile runs")
    expect(page).to have_content("Total Time (min)")
    expect(page).to have_content("Elevation (ft)")
    expect(page).to have_css("path")
  end

  scenario "user creates Average Speed v. Elevation graph", js: true do
    user = create(:user)
    workout1, workout2 = load_workouts(user)

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit elevation_path

    fill_in "minimum_distance", with: "2"
    fill_in "maximum_distance", with: "5"
    select "Average Speed", from: "y-axis"

    expect(page).to have_content("Elevation vs. Average Speed for 2 - 5 mile runs")
    expect(page).to have_content("Average Speed (mph)")
    expect(page).to have_content("Elevation (ft)")
    expect(page).to have_css("path")
  end

  scenario "user creates Time Spent Resting v. Elevation graph", js: true do
    user = create(:user)
    workout1, workout2 = load_workouts(user)

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit elevation_path

    fill_in "minimum_distance", with: "2"
    fill_in "maximum_distance", with: "6"
    select "Time Spent Resting", from: "y-axis"

    expect(page).to have_content("Elevation vs. Time Spent Resting for 2 - 6 mile runs")
    expect(page).to have_content("Time Spent Resting (min)")
    expect(page).to have_content("Elevation (ft)")
    expect(page).to have_css("path")
  end

  def load_workouts(user)
    workout1 = create(:workout, user: user,
                                distance: 8000,
                                average_speed: 4.5,
                                elapsed_time: 3000,
                                active_time: 2800)
    workout2 = create(:workout, user: user,
                                distance: 6000,
                                average_speed: 3.5,
                                elapsed_time: 2500,
                                active_time: 2400)
    workout1.route.update_elevation(2000)
    workout2.route.update_elevation(2500)

    [workout1, workout2]
  end
end
