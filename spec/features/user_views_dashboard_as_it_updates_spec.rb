require "rails_helper"

RSpec.feature "User views dashboard as it updates" do
  scenario "new run is added after user visits dashboard", js: true do
    user = create(:user_with_workouts_and_routes)

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit dashboard_path

    within "#total-workouts" do
      expect(page).to have_content(2)
    end

    within "#total-calories" do
      expect(page).to have_content(1300)
    end

    within "#average-distance" do
      expect(page).to have_content(5.06)
    end

    within "#total-distance" do
      expect(page).to have_content(10.11)
    end

    within "#total-time" do
      expect(page).to have_content(1.69)
    end

    create(:workout, user: user)
    sleep(1)

    within "#total-workouts" do
      expect(page).to have_content(3)
    end

    within "#total-calories" do
      expect(page).to have_content(1950)
    end

    within "#average-distance" do
      expect(page).to have_content(5.05)
    end

    within "#total-distance" do
      expect(page).to have_content(15.16)
    end

    within "#total-time" do
      expect(page).to have_content(2.54)
    end
  end
end
