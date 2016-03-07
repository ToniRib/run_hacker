require "rails_helper"

RSpec.feature "User views season graph" do
  scenario "initial load prior to selections" do
    user = create(:user)

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit season_path

    expect(page).to have_content("Season Analysis")
    expect(page).to have_content("Distance Range")
    expect(page).to have_content("Y-axis")
    expect(page).to have_button("Create Graph")
    expect(page).to have_select("y-axis", options: ["Average Total Time", "Average Speed"])
  end

  scenario "user creates Average Total Time v. Season graph", js: true do
    user = create(:user)
    workout1, workout2 = load_workouts(user)

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit season_path

    fill_in "minimum_distance", with: "3"
    fill_in "maximum_distance", with: "5"
    click_on "Create Graph"

    expect(page).to have_content("Season vs. Average Total Time for 3 - 5 mile runs")
    expect(page).to have_content("Average Total Time (min)")
    expect(page).to have_css("path")
  end

  scenario "user creates Average Speed v. Season graph", js: true do
    user = create(:user)
    workout1, workout2 = load_workouts(user)

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit season_path

    fill_in "minimum_distance", with: "2"
    fill_in "maximum_distance", with: "5"
    select "Average Speed", from: "y-axis"

    expect(page).to have_content("Season vs. Average Speed for 2 - 5 mile runs")
    expect(page).to have_content("Average Speed (mph)")
    expect(page).to have_css("path")
  end

  def load_workouts(user)
    workout1 = create(:workout, elapsed_time: 800,
                                average_speed: 6,
                                starting_datetime: DateTime.new(2015, 1, 20),
                                user: user)
    workout2 = create(:workout, elapsed_time: 600,
                                average_speed: nil,
                                starting_datetime: DateTime.new(2015, 7, 20),
                                user: user)

    [workout1, workout2]
  end
end
