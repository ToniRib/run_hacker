require "rails_helper"

RSpec.describe Presenters::WorkoutPresenter, type: :model do
  describe "#display_starting_date_no_time" do
    it "displays the starting date without time if a location exists" do
      workout = create(:workout)
      workout_presenter = Presenters::WorkoutPresenter.new(workout)

      date = workout_presenter.display_starting_date_no_time

      expect(date).to eq("2016-02-13")
    end

    it "displays an empty string of no location exists" do
      workout = create(:workout, route: nil)
      workout_presenter = Presenters::WorkoutPresenter.new(workout)

      date = workout_presenter.display_starting_date_no_time

      expect(date).to eq("")
    end
  end

  describe "#display_distance_in_miles" do
    it "displays the distance in miles if a distance exists" do
      workout = create(:workout)
      workout_presenter = Presenters::WorkoutPresenter.new(workout)

      date = workout_presenter.display_distance_in_miles

      expect(date).to eq(5.05)
    end

    it "displays an empty string of no distance exists" do
      workout = create(:workout, distance: nil)
      workout_presenter = Presenters::WorkoutPresenter.new(workout)

      date = workout_presenter.display_distance_in_miles

      expect(date).to eq("")
    end
  end

  describe "#display_average_speed_in_mph" do
    it "displays the avg speed in mph if an avg speed exists" do
      workout = create(:workout)
      workout_presenter = Presenters::WorkoutPresenter.new(workout)

      date = workout_presenter.display_average_speed_in_mph

      expect(date).to eq(5.97)
    end

    it "displays an empty string of no avg speed exists" do
      workout = create(:workout, average_speed: nil)
      workout_presenter = Presenters::WorkoutPresenter.new(workout)

      date = workout_presenter.display_average_speed_in_mph

      expect(date).to eq("")
    end
  end

  describe "#display_elapsed_time_in_minutes" do
    it "displays the elapsed time in minutes if one exists" do
      workout = create(:workout)
      workout_presenter = Presenters::WorkoutPresenter.new(workout)

      date = workout_presenter.display_elapsed_time_in_minutes

      expect(date).to eq(50.77)
    end

    it "displays an empty string of no elapsed time exists" do
      workout = create(:workout, elapsed_time: nil)
      workout_presenter = Presenters::WorkoutPresenter.new(workout)

      date = workout_presenter.display_elapsed_time_in_minutes

      expect(date).to eq("")
    end
  end

  describe "#display_calories_burned_in_kcal" do
    it "displays the calories burned in kcal if metabolic energy exists" do
      workout = create(:workout)
      workout_presenter = Presenters::WorkoutPresenter.new(workout)

      date = workout_presenter.display_calories_burned_in_kcal

      expect(date).to eq(650.0)
    end

    it "displays an empty string of no metabolic energy exists" do
      workout = create(:workout, metabolic_energy: nil)
      workout_presenter = Presenters::WorkoutPresenter.new(workout)

      date = workout_presenter.display_calories_burned_in_kcal

      expect(date).to eq("")
    end
  end

  describe "#display_city_and_state" do
    it "displays the city and state if a location exists" do
      workout = create(:workout)
      workout_presenter = Presenters::WorkoutPresenter.new(workout)

      date = workout_presenter.display_city_and_state

      expect(date).to eq("Denver, CO")
    end

    it "displays an empty string of no location exists" do
      workout = create(:workout, route: nil)
      workout_presenter = Presenters::WorkoutPresenter.new(workout)

      date = workout_presenter.display_city_and_state

      expect(date).to eq("")
    end
  end

  describe "#display_elevation_in_feet" do
    it "displays the elevation in feet if a route and elevation exists" do
      workout = create(:workout)
      workout_presenter = Presenters::WorkoutPresenter.new(workout)

      date = workout_presenter.display_elevation_in_feet

      expect(date).to eq(5431.58)
    end

    it "displays an empty string of no route exists" do
      workout = create(:workout, route: nil)
      workout_presenter = Presenters::WorkoutPresenter.new(workout)

      date = workout_presenter.display_elevation_in_feet

      expect(date).to eq("")
    end

    it "displays an empty string of no elevation exists" do
      route = create(:route, elevation: nil)
      workout = create(:workout, route: route)
      workout_presenter = Presenters::WorkoutPresenter.new(workout)

      date = workout_presenter.display_elevation_in_feet

      expect(date).to eq("")
    end
  end
end
