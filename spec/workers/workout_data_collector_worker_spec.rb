require "rails_helper"

RSpec.describe "WorkoutDataCollectorWorker" do
  describe "#perform" do
    before do
      allow(MmfWorkoutAggregateService).to receive(:load_workouts)
      allow(MmfRouteService).to receive(:load_routes)
      allow(GoogleGeocoderService).to receive(:update_routes_with_zipcodes)
      allow(GoogleTimezoneService).to receive(:update_routes_with_timezones)
      allow(GoogleElevationService).to receive(:update_routes_with_elevation)
      allow(WeathersourceTemperatureService).to receive(:update_workouts_with_temperature)
    end

    let(:expected_id) { 1 }

    it "should load workouts" do
      expect(MmfWorkoutAggregateService).to receive(:load_workouts).with(expected_id)

      WorkoutDataCollectorWorker.new.perform(expected_id)
    end

    it "should load routes" do
      expect(MmfRouteService).to receive(:load_routes).with(expected_id)

      WorkoutDataCollectorWorker.new.perform(expected_id)
    end

    it "should update routes with zipcodes" do
      expect(GoogleGeocoderService).to receive(:update_routes_with_zipcodes).with(expected_id)

      WorkoutDataCollectorWorker.new.perform(expected_id)
    end

    it "should update routes with timezones" do
      expect(GoogleTimezoneService).to receive(:update_routes_with_timezones).with(expected_id)

      WorkoutDataCollectorWorker.new.perform(expected_id)
    end

    it "should update routes with elevations" do
      expect(GoogleElevationService).to receive(:update_routes_with_elevation).with(expected_id)

      WorkoutDataCollectorWorker.new.perform(expected_id)
    end

    it "should update workouts with temperatures" do
      expect(WeathersourceTemperatureService).to receive(:update_workouts_with_temperature).with(expected_id)

      WorkoutDataCollectorWorker.new.perform(expected_id)
    end
  end
end
