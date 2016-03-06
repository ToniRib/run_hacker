require 'rails_helper'

RSpec.describe WorkoutWithTimeseries, type: :model do
  describe "#display_temperature" do
    it "displays the temperature with °F if it exists" do
      workout = create(:workout, temperature: 78)
      timeseries = create_timeseries

      workout_with_timeseries = WorkoutWithTimeseries.new(workout, timeseries)

      temp_display = workout_with_timeseries.display_temperature

      expect(temp_display).to eq("78.0 °F")
    end

    it "displays Not Available if temperature does not exist" do
      workout = create(:workout, temperature: nil)
      timeseries = create_timeseries

      workout_with_timeseries = WorkoutWithTimeseries.new(workout, timeseries)

      temp_display = workout_with_timeseries.display_temperature

      expect(temp_display).to eq("Not Available")
    end
  end

  describe "#display_elapsed_time" do
    it "displays the elapsed_time with minutes if it exists" do
      workout = create(:workout, elapsed_time: 7800)
      timeseries = create_timeseries

      workout_with_timeseries = WorkoutWithTimeseries.new(workout, timeseries)

      elapsed_time_display = workout_with_timeseries.display_elapsed_time

      expect(elapsed_time_display).to eq("130.0 minutes")
    end

    it "displays Not Available if elapsed_time does not exist" do
      workout = create(:workout, elapsed_time: nil)
      timeseries = create_timeseries

      workout_with_timeseries = WorkoutWithTimeseries.new(workout, timeseries)

      elapsed_time_display = workout_with_timeseries.display_elapsed_time

      expect(elapsed_time_display).to eq("Not Available")
    end
  end

  describe "#display_calories_burned" do
    it "displays the calories_burned with kcal if it exists" do
      workout = create(:workout, metabolic_energy: 780000)
      timeseries = create_timeseries

      workout_with_timeseries = WorkoutWithTimeseries.new(workout, timeseries)

      calories_burned_display = workout_with_timeseries.display_calories_burned

      expect(calories_burned_display).to eq("186.42 kcal")
    end

    it "displays Not Available if calories_burned does not exist" do
      workout = create(:workout, metabolic_energy: nil)
      timeseries = create_timeseries

      workout_with_timeseries = WorkoutWithTimeseries.new(workout, timeseries)

      calories_burned_display = workout_with_timeseries.display_calories_burned

      expect(calories_burned_display).to eq("Not Available")
    end
  end

  describe "#display_average_speed" do
    it "displays the average_speed with mph if it exists" do
      workout = create(:workout, average_speed: 3.56)
      timeseries = create_timeseries

      workout_with_timeseries = WorkoutWithTimeseries.new(workout, timeseries)

      average_speed_display = workout_with_timeseries.display_average_speed

      expect(average_speed_display).to eq("7.96 mph")
    end

    it "displays Not Available if average_speed does not exist" do
      workout = create(:workout, average_speed: nil)
      timeseries = create_timeseries

      workout_with_timeseries = WorkoutWithTimeseries.new(workout, timeseries)

      average_speed_display = workout_with_timeseries.display_average_speed

      expect(average_speed_display).to eq("Not Available")
    end
  end

  describe "#display_min_speed" do
    it "displays the min_speed with mph if it exists" do
      workout = create(:workout)
      timeseries = create_timeseries

      workout_with_timeseries = WorkoutWithTimeseries.new(workout, timeseries)

      min_speed_display = workout_with_timeseries.display_min_speed

      expect(min_speed_display).to eq("10.22 mph")
    end

    it "displays Not Available if min_speed does not exist" do
      workout = create(:workout)
      timeseries = create_timeseries(nil)

      workout_with_timeseries = WorkoutWithTimeseries.new(workout, timeseries)

      min_speed_display = workout_with_timeseries.display_min_speed

      expect(min_speed_display).to eq("Not Available")
    end
  end

  describe "#display_max_speed" do
    it "displays the max_speed with mph if it exists" do
      workout = create(:workout)
      timeseries = create_timeseries

      workout_with_timeseries = WorkoutWithTimeseries.new(workout, timeseries)

      max_speed_display = workout_with_timeseries.display_max_speed

      expect(max_speed_display).to eq("18.67 mph")
    end

    it "displays Not Available if max_speed does not exist" do
      workout = create(:workout)
      timeseries = create_timeseries(4.567, nil)

      workout_with_timeseries = WorkoutWithTimeseries.new(workout, timeseries)

      max_speed_display = workout_with_timeseries.display_max_speed

      expect(max_speed_display).to eq("Not Available")
    end
  end

  describe "#display_max_elevation" do
    it "displays the max_elevation with ft if it exists" do
      workout = create(:workout)
      timeseries = create_timeseries

      workout_with_timeseries = WorkoutWithTimeseries.new(workout, timeseries)

      max_elevation_display = workout_with_timeseries.display_max_elevation

      expect(max_elevation_display).to eq("72.6 ft")
    end

    it "displays Not Available if max_elevation does not exist" do
      workout = create(:workout)
      timeseries = WorkoutTimeseries.new(api_data_without_elevations)

      workout_with_timeseries = WorkoutWithTimeseries.new(workout, timeseries)

      max_elevation_display = workout_with_timeseries.display_max_elevation

      expect(max_elevation_display).to eq("Not Available")
    end
  end

  describe "#display_min_elevation" do
    it "displays the min_elevation with ft if it exists" do
      workout = create(:workout)
      timeseries = create_timeseries

      workout_with_timeseries = WorkoutWithTimeseries.new(workout, timeseries)

      min_elevation_display = workout_with_timeseries.display_min_elevation

      expect(min_elevation_display).to eq("65.26 ft")
    end

    it "displays Not Available if min_elevation does not exist" do
      workout = create(:workout)
      timeseries = WorkoutTimeseries.new(api_data_without_elevations)

      workout_with_timeseries = WorkoutWithTimeseries.new(workout, timeseries)

      min_elevation_display = workout_with_timeseries.display_min_elevation

      expect(min_elevation_display).to eq("Not Available")
    end
  end

  def create_timeseries(min_speed = 4.567, max_speed = 8.345)
    WorkoutTimeseries.new(api_data(min_speed, max_speed))
  end

  def api_data(min_speed, max_speed)
    {
      aggregates: {
        speed_min: min_speed,
        speed_max: max_speed
      },
      time_series: {
        position: [
          [0.131, {
              "lat": 38.78214621,
              "lng": -77.01499606,
              "elevation": 22.13
          }],
          [12.131, {
              "lat": 38.7822010006,
              "lng": -77.0151513974,
              "elevation": 20.76
          }],
          [14.131, {
              "lat": 38.7822198315,
              "lng": -77.0153191478,
              "elevation": 19.89
          }]
        ],
        speed: [
          [0.131, 0.0],
          [12.131, 0.5],
          [14.131, 1.0]
        ],
        distance: [
          [0.131, 0.0],
          [12.131, 14.8046369553],
          [14.131, 29.529838562]
        ]
      }
    }
  end

  def api_data_without_elevations
    {
      aggregates: {
        speed_min: 4.567,
        speed_max: 8.345
      },
      time_series: {
        position: [
          [0.131, {
              "lat": 38.78214621,
              "lng": -77.01499606
          }],
          [12.131, {
              "lat": 38.7822010006,
              "lng": -77.0151513974
          }],
          [14.131, {
              "lat": 38.7822198315,
              "lng": -77.0153191478
          }]
        ],
        speed: [
          [0.131, 0.0],
          [12.131, 0.5],
          [14.131, 1.0]
        ],
        distance: [
          [0.131, 0.0],
          [12.131, 14.8046369553],
          [14.131, 29.529838562]
        ]
      }
    }
  end
end
