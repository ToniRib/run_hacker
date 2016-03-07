require "rails_helper"
require "sidekiq/testing"
Sidekiq::Testing.fake!

RSpec.feature "User logs in" do
  scenario "clicks on create account or log in" do
    visit root_path
    mock_auth_hash

    VCR.use_cassette "user_logs_in" do
      click_on "Create an Account or Log In with MapMyFitness"
    end

    expect(current_path).to eq(dashboard_path)

    within "nav" do
      expect(page).not_to have_link "Log In", "/auth/mapmyfitness"
      expect(page).to have_link "Log Out", logout_path
    end

    user = User.last
    presenter = Presenters::DashboardPresenter.new(user)

    expect(page).to have_content user.display_name
    expect(page).to have_content user.email
    expect(page).to have_content user.username
    expect(page.find('.user-profile-photo')['src']).to have_content toni_profile_photo

    expect(page).to have_content user.number_of_workouts
    expect(page).to have_content presenter.total_distance_in_miles
    expect(page).to have_content presenter.average_distance_in_miles
    expect(page).to have_content presenter.total_time_in_hours
    expect(page).to have_content presenter.total_calories_in_kcal
    expect(page).to have_content user.date_joined_formatted
  end

  def toni_profile_photo
    "https://graph.facebook.com/1277220131/picture?height=300&width=300"
  end
end
