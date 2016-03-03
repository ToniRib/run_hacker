require "rails_helper"

RSpec.describe "Guest tries to visit unauthorized pages" do
  describe "dashboard" do
    it "returns them to the root path" do
      visit dashboard_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Must be logged in to view that page")
    end
  end

  describe "temperature" do
    it "returns them to the root path" do
      visit temperature_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Must be logged in to view that page")
    end
  end

  describe "workouts" do
    it "returns them to the root path" do
      visit workouts_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Must be logged in to view that page")
    end
  end
end
