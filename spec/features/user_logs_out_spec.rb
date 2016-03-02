require "rails_helper"
require "sidekiq/testing"
Sidekiq::Testing.fake!

RSpec.describe "User logs out" do
  it "logs out the user and brings them to the landing page" do
    visit root_path
    mock_auth_hash

    VCR.use_cassette "user_logs_in" do
      click_on "Log In"
    end

    within "nav" do
      expect(page).not_to have_link "Log In", "/auth/mapmyfitness"
      expect(page).to have_link "Log Out", logout_path

      click_on "Log Out"
    end

    expect(current_path).to eq(root_path)

    within "nav" do
      expect(page).to have_link "Log In", "/auth/mapmyfitness"
      expect(page).not_to have_link "Log Out", logout_path
    end
  end
end
