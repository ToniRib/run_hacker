require "rails_helper"

RSpec.feature "User views workouts listing" do
  scenario "user has a listing of two workouts" do
    user = create(:user)
    workout1 = create(:workout, user: user)
    workout2 = create(:workout, distance: 7200,
                                average_speed: 3.5,
                                elapsed_time: 2800,
                                metabolic_energy: 2508000,
                                user: user)
    workout2.route.update_elevation(1700.55)
    workout2.location.update_attribute(:city, "Los Angeles")
    workout2.location.update_attribute(:state, "CA")

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit workouts_path

    within "thead" do
      expect(page).to have_content("Date")
      expect(page).to have_content("Distance(mi)")
      expect(page).to have_content("Average Speed(mph)")
      expect(page).to have_content("Elapsed Time(min)")
      expect(page).to have_content("Calories Burned(kcal)")
      expect(page).to have_content("Location")
      expect(page).to have_content("Elevation(feet)")
    end

    within "tbody" do
      expect(page).to have_content(workout1.starting_date_no_time)
      expect(page).to have_content(workout1.distance_in_miles)
      expect(page).to have_content(workout1.average_speed_in_mph)
      expect(page).to have_content(workout1.elapsed_time_in_minutes)
      expect(page).to have_content(workout1.calories_burned_in_kcal)
      expect(page).to have_content(workout1.location.city_and_state)
      expect(page).to have_content(workout1.route.elevation_in_feet)
      expect(page).to have_xpath("//tr[@data-link='/workouts/#{workout1.id}']")

      expect(page).to have_content(workout2.starting_date_no_time)
      expect(page).to have_content(workout2.distance_in_miles)
      expect(page).to have_content(workout2.average_speed_in_mph)
      expect(page).to have_content(workout2.elapsed_time_in_minutes)
      expect(page).to have_content(workout2.calories_burned_in_kcal)
      expect(page).to have_content(workout2.location.city_and_state)
      expect(page).to have_content(workout2.route.elevation_in_feet)
      expect(page).to have_xpath("//tr[@data-link='/workouts/#{workout2.id}']")
    end
  end

  scenario "user has no workouts loaded" do
    user = create(:user)
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit workouts_path

    within "thead" do
      expect(page).to have_content("Date")
      expect(page).to have_content("Distance(mi)")
      expect(page).to have_content("Average Speed(mph)")
      expect(page).to have_content("Elapsed Time(min)")
      expect(page).to have_content("Calories Burned(kcal)")
      expect(page).to have_content("Location")
      expect(page).to have_content("Elevation(feet)")
    end

    within "tbody" do
      expect(page).to_not have_content("tr")
    end
  end

  scenario "user sorts by distance", js: true do
    user = create(:user)
    workout1 = create(:workout, distance: 500, user: user)
    workout2 = create(:workout, distance: 1000, user: user)

    short_distance = workout1.distance_in_miles
    long_distance = workout2.distance_in_miles

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit workouts_path

    find("#distance-sort").click

    within "tbody tr:nth-child(1)" do
      expect(page).to have_content(short_distance)
    end

    within "tbody tr:nth-child(2)" do
      expect(page).to have_content(long_distance)
    end

    find("#distance-sort").click

    within "tbody tr:nth-child(1)" do
      expect(page).to have_content(long_distance)
    end

    within "tbody tr:nth-child(2)" do
      expect(page).to have_content(short_distance)
    end
  end
end
