require "rails_helper"

RSpec.describe Presenters::DashboardPresenter, type: :model do
  describe "#total_distance_in_miles" do
    it "calculates the total distance across all workouts" do
      user = create(:user_with_workouts_and_routes)
      dashboard_presenter = Presenters::DashboardPresenter.new(user)

      miles = dashboard_presenter.total_distance_in_miles

      expect(miles).to eq(10.11)
    end

    it "returns zero if no workouts exist" do
      user = create(:user)
      dashboard_presenter = Presenters::DashboardPresenter.new(user)

      miles = dashboard_presenter.total_distance_in_miles

      expect(miles).to eq(0)
    end
  end

  describe "#average_distance_in_miles" do
    it "calculates the average distance across all workouts" do
      user = create(:user_with_workouts_and_routes)
      dashboard_presenter = Presenters::DashboardPresenter.new(user)

      miles = dashboard_presenter.average_distance_in_miles

      expect(miles).to eq(5.06)
    end

    it "returns zero if no workouts exist" do
      user = create(:user)
      dashboard_presenter = Presenters::DashboardPresenter.new(user)

      miles = dashboard_presenter.average_distance_in_miles

      expect(miles).to eq(0)
    end
  end

  describe "#total_time_in_hours" do
    it "calculates the total time spent working out" do
      user = create(:user_with_workouts_and_routes)
      dashboard_presenter = Presenters::DashboardPresenter.new(user)

      total_time = dashboard_presenter.total_time_in_hours

      expect(total_time).to eq(1.69)
    end

    it "returns zero if no workouts exist" do
      user = create(:user)
      dashboard_presenter = Presenters::DashboardPresenter.new(user)

      total_time = dashboard_presenter.total_time_in_hours

      expect(total_time).to eq(0)
    end
  end

  describe "#total_calories_in_kcal" do
    it "calculates the total amount of calories burned across all workouts" do
      user = create(:user_with_workouts_and_routes)
      dashboard_presenter = Presenters::DashboardPresenter.new(user)

      calories = dashboard_presenter.total_calories_in_kcal

      expect(calories).to eq(1300)
    end

    it "returns zero if no workouts exist" do
      user = create(:user)
      dashboard_presenter = Presenters::DashboardPresenter.new(user)

      calories = dashboard_presenter.total_calories_in_kcal

      expect(calories).to eq(0)
    end
  end
end
