require "rails_helper"

RSpec.describe Presenters::ElevationPresenter, type: :model do
  describe "#distance_elevation_and_total_time" do
    it "returns nested arrays for for records with elapsed times and routes" do
      user = create(:user)
      route1 = create(:route, elevation: 800)
      route2 = create(:route, elevation: 600)
      workout1 = create(:workout, distance: 8000,
                                  elapsed_time: 300,
                                  route: route1,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  elapsed_time: 500,
                                  route: route2,
                                  user: user)

      data = Presenters::ElevationPresenter.new(user).distance_elevation_and_total_time
      expected = [[2.49, 1968.5, 8.33], [4.97, 2624.67, 5.0]]

      expect(data).to eq(expected)
    end

    it "does not return records with no elapsed time" do
      user = create(:user)
      route1 = create(:route, elevation: 800)
      route2 = create(:route, elevation: 600)
      workout1 = create(:workout, distance: 8000,
                                  elapsed_time: 300,
                                  route: route1,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  elapsed_time: nil,
                                  route: route2,
                                  user: user)

      data = Presenters::ElevationPresenter.new(user).distance_elevation_and_total_time
      expected = [[4.97, 2624.67, 5.0]]

      expect(data).to eq(expected)
    end

    it "does not return records with no associated route/location" do
      user = create(:user)
      route1 = create(:route, elevation: 800)
      workout1 = create(:workout, distance: 8000,
                                  elapsed_time: 300,
                                  route: route1,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  elapsed_time: 300,
                                  route: nil,
                                  user: user)

      data = Presenters::ElevationPresenter.new(user).distance_elevation_and_total_time
      expected = [[4.97, 2624.67, 5.0]]

      expect(data).to eq(expected)
    end
  end

  describe "#distance_elevation_and_average_speed" do
    it "returns records with an average speed and associated route" do
      user = create(:user)
      route1 = create(:route, elevation: 800)
      route2 = create(:route, elevation: 600)
      workout1 = create(:workout, distance: 8000,
                                  average_speed: 300,
                                  route: route1,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  average_speed: 500,
                                  route: route2,
                                  user: user)

      data = Presenters::ElevationPresenter.new(user).distance_elevation_and_average_speed
      expected = [[2.49, 1968.5, 1118.47], [4.97, 2624.67, 671.08]]

      expect(data).to eq(expected)
    end

    it "does not return records with no average speed" do
      user = create(:user)
      route1 = create(:route, elevation: 800)
      route2 = create(:route, elevation: 600)
      workout1 = create(:workout, distance: 8000,
                                  average_speed: 300,
                                  route: route1,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  average_speed: nil,
                                  route: route2,
                                  user: user)

      data = Presenters::ElevationPresenter.new(user).distance_elevation_and_average_speed
      expected = [[4.97, 2624.67, 671.08]]

      expect(data).to eq(expected)
    end

    it "does not return records with no associated route/location" do
      user = create(:user)
      route1 = create(:route, elevation: 600)
      workout1 = create(:workout, distance: 8000,
                                  average_speed: 300,
                                  route: route1,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  average_speed: 500,
                                  route: nil,
                                  user: user)

      data = Presenters::ElevationPresenter.new(user).distance_elevation_and_average_speed
      expected = [[4.97, 1968.5, 671.08]]

      expect(data).to eq(expected)
    end
  end

  describe "#distance_elevation_and_time_spent_resting" do
    it "returns nested arrays for records with all required parameters" do
      user = create(:user)
      route1 = create(:route, elevation: 800)
      route2 = create(:route, elevation: 600)
      workout1 = create(:workout, distance: 8000,
                                  elapsed_time: 300,
                                  active_time: 200,
                                  route: route1,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  elapsed_time: 400,
                                  active_time: 200,
                                  route: route2,
                                  user: user)

      data = Presenters::ElevationPresenter.new(user).distance_elevation_and_time_spent_resting
      expected = [[2.49, 1968.5, 3.33], [4.97, 2624.67, 1.67]]

      expect(data).to eq(expected)
    end

    it "does not return records with no elapsed time" do
      user = create(:user)
      route1 = create(:route, elevation: 800)
      route2 = create(:route, elevation: 600)
      workout1 = create(:workout, distance: 8000,
                                  elapsed_time: 300,
                                  active_time: 200,
                                  route: route1,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  elapsed_time: nil,
                                  active_time: 200,
                                  route: route2,
                                  user: user)

      data = Presenters::ElevationPresenter.new(user).distance_elevation_and_time_spent_resting
      expected = [[4.97, 2624.67, 1.67]]

      expect(data).to eq(expected)
    end

    it "does not return records with no active time" do
      user = create(:user)
      route1 = create(:route, elevation: 800)
      route2 = create(:route, elevation: 600)
      workout1 = create(:workout, distance: 8000,
                                  elapsed_time: 300,
                                  active_time: 200,
                                  route: route1,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  elapsed_time: 300,
                                  active_time: nil,
                                  route: route2,
                                  user: user)

      data = Presenters::ElevationPresenter.new(user).distance_elevation_and_time_spent_resting
      expected = [[4.97, 2624.67, 1.67]]

      expect(data).to eq(expected)
    end

    it "does not return records with no associated route/location" do
      user = create(:user)
      route1 = create(:route, elevation: 800)
      workout1 = create(:workout, distance: 8000,
                                  elapsed_time: 300,
                                  active_time: 200,
                                  route: route1,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  elapsed_time: 300,
                                  active_time: 200,
                                  route: nil,
                                  user: user)

      data = Presenters::ElevationPresenter.new(user).distance_elevation_and_time_spent_resting
      expected = [[4.97, 2624.67, 1.67]]

      expect(data).to eq(expected)
    end

    it "does not return records where time spent resting is negative" do
      user = create(:user)
      route1 = create(:route, elevation: 800)
      route2 = create(:route, elevation: 600)
      workout1 = create(:workout, distance: 8000,
                                  elapsed_time: 300,
                                  active_time: 200,
                                  route: route1,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  elapsed_time: 100,
                                  active_time: 200,
                                  route: route2,
                                  user: user)

      data = Presenters::ElevationPresenter.new(user).distance_elevation_and_time_spent_resting
      expected = [[4.97, 2624.67, 1.67]]

      expect(data).to eq(expected)
    end
  end
end
