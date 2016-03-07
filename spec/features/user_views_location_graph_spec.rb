require "rails_helper"

RSpec.feature "User views location graph" do
  scenario "initial load prior to selections" do
    user = create(:user)

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit location_path

    expect(page).to have_content("Location Analysis")
    expect(page).to have_content("Distance Range")
    expect(page).to have_content("Locations (select multiple)")
    expect(page).to have_content("Select All")
    expect(page).to have_content("Y-axis")
    expect(page).to have_button("Create Graph")
    expect(page).to have_select("y-axis", options: ["Average Total Time", "Average Speed"])
  end

  scenario "user creates Total Time v. Location graph", js: true do
    user = create(:user)
    workout1, workout2 = load_workouts(user)

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit location_path

    fill_in "minimum_distance", with: "3"
    fill_in "maximum_distance", with: "5"
    click_on "Select All"
    click_on "Create Graph"

    expect(page).to have_content("Location vs. Average Total Time for 3 - 5 mile runs")
    expect(page).to have_content("Average Total Time (min)")
    expect(page).to have_content("Denver, CO")
    expect(page).to have_content("Los Angeles, CA")
    expect(page).to have_css("path")
  end

  scenario "user creates Average Speed v. Location graph", js: true do
    user = create(:user)
    workout1, workout2 = load_workouts(user)

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit location_path

    fill_in "minimum_distance", with: "2"
    fill_in "maximum_distance", with: "5"
    click_on "Select All"
    select "Average Speed", from: "y-axis"

    expect(page).to have_content("Location vs. Average Speed for 2 - 5 mile runs")
    expect(page).to have_content("Average Speed (mph)")
    expect(page).to have_content("Denver, CO")
    expect(page).to have_css("path")
  end

  def load_workouts(user)
    location1 = create(:location, city: "Denver", state: "CO")
    location2 = create(:location, city: "Los Angeles", state: "CA")
    route1 = create(:route, location: location1)
    route2 = create(:route, location: location2)
    workout1 = create(:workout, route: route1,
                                elapsed_time: 800,
                                average_speed: 6)
    workout2 = create(:workout, route: route2,
                                elapsed_time: 600,
                                average_speed: nil)
    user.workouts << [workout1, workout2]

    [workout1, workout2]
  end
end
