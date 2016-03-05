require "rails_helper"

RSpec.describe MmfWorkoutTimeseriesService do
  describe "initialize" do
    it "can be initialized with valid parameters" do
      user = User.create(user_params)
      map_my_fitness_id = "932453273"
      service = MmfWorkoutTimeseriesService.new(map_my_fitness_id, user)

      expect(service.user).to eq(user)
      expect(service.map_my_fitness_id).to eq(map_my_fitness_id)
      expect(service.connection.class).to eq(Faraday::Connection)
    end
  end

  describe "get_timeseries" do
    it "gets the full time series for a specific run" do
      user = User.create(user_params)
      map_my_fitness_id = "932453273"
      service = MmfWorkoutTimeseriesService.new(map_my_fitness_id, user)

      timeseries = VCR.use_cassette("load_timeseries") do
        service.get_timeseries
      end

      expect(timeseries.class).to eq(WorkoutTimeseries)
      expect(timeseries.points.count).to eq(577)
      expect(timeseries.min_speed).to eq(1.1110553344)
      expect(timeseries.max_speed).to eq(7.053754752)
    end
  end
end
