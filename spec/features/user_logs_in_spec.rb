require "rails_helper"
require "sidekiq/testing"
Sidekiq::Testing.fake!

RSpec.describe "User logs in" do
  it "logs in the user and brings them to their dashboard" do
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

    expect(page).to have_content user.display_name
    expect(page).to have_content user.email
    expect(page).to have_content user.username
    expect(page.find('.user-profile-photo')['src']).to have_content toni_profile_photo
  end

  def toni_profile_photo
    "https://graph.facebook.com/1277220131/picture?height=300&width=300"
  end
end
