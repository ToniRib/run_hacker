require "rails_helper"

RSpec.describe Presenters::LocationPresenter, type: :model do
  describe "#distance_location_and_total_time" do
    it "returns nested arrays for for records with elapsed times and routes" do
      user = create(:user)
      workout1 = create(:workout, distance: 8000,
                                  elapsed_time: 300,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 19:16:52 UTC"),
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  elapsed_time: 500,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 12:16:52 UTC"),
                                  user: user)

      data = Presenters::LocationPresenter.new(user).distance_location_and_total_time
      expected = { "Denver, CO" => [[2.49, 8.33], [4.97, 5.0]] }

      expect(data).to eq(expected)
    end

    it "returns times grouped by location" do
      user = create(:user)
      location1 = create(:location, city: "Denver", state: "CO")
      location2 = create(:location, city: "Los Angeles", state: "CA")
      route1 = create(:route, location: location1)
      route2 = create(:route, location: location2)
      workout1 = create(:workout, route: route1, user: user)
      workout2 = create(:workout, route: route2, user: user)

      data = Presenters::LocationPresenter.new(user).distance_location_and_total_time
      expected = { "Denver, CO" => [[5.05, 50.77]],
                   "Los Angeles, CA" => [[5.05, 50.77]]
      }

      expect(data).to eq(expected)
    end

    it "does not return records with no elapsed time" do
      user = create(:user)
      workout1 = create(:workout, distance: 8000,
                                  elapsed_time: 300,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 19:16:52 UTC"),
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  elapsed_time: nil,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 12:16:52 UTC"),
                                  user: user)

      data = Presenters::LocationPresenter.new(user).distance_location_and_total_time
      expected = { "Denver, CO" => [[4.97, 5.0]] }

      expect(data).to eq(expected)
    end

    it "does not return records with no associated route/location" do
      user = create(:user)
      workout1 = create(:workout, distance: 8000,
                                  elapsed_time: 300,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 19:16:52 UTC"),
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  elapsed_time: 500,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 12:16:52 UTC"),
                                  route_id: nil,
                                  user: user)

      data = Presenters::LocationPresenter.new(user).distance_location_and_total_time
      expected = { "Denver, CO" => [[4.97, 5.0]] }

      expect(data).to eq(expected)
    end
  end

  describe "#distance_location_and_average_speed" do
    it "returns nested arrays for records with an average speed" do
      user = create(:user)
      workout1 = create(:workout, distance: 8000,
                                  average_speed: 300,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 19:16:52 UTC"),
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  average_speed: 500,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 12:16:52 UTC"),
                                  user: user)

      data = Presenters::LocationPresenter.new(user).distance_location_and_average_speed
      expected = { "Denver, CO" => [[2.49, 1118.47], [4.97, 671.08]] }

      expect(data).to eq(expected)
    end

    it "returns speeds grouped by location" do
      user = create(:user)
      location1 = create(:location, city: "Denver", state: "CO")
      location2 = create(:location, city: "Los Angeles", state: "CA")
      route1 = create(:route, location: location1)
      route2 = create(:route, location: location2)
      workout1 = create(:workout, route: route1, user: user)
      workout2 = create(:workout, route: route2, user: user)

      data = Presenters::LocationPresenter.new(user).distance_location_and_average_speed
      expected = { "Denver, CO" => [[5.05, 5.97]],
                   "Los Angeles, CA" => [[5.05, 5.97]]
      }

      expect(data).to eq(expected)
    end

    it "does not return records with no average speed" do
      user = create(:user)
      workout1 = create(:workout, distance: 8000,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 19:16:52 UTC"),
                                  average_speed: 3,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 12:16:52 UTC"),
                                  average_speed: nil,
                                  user: user)

      data = Presenters::LocationPresenter.new(user).distance_location_and_average_speed
      expected = { "Denver, CO" => [[4.97, 6.71]] }

      expect(data).to eq(expected)
    end

    it "does not return records with no associated route/location" do
      user = create(:user)
      workout1 = create(:workout, distance: 8000,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 19:16:52 UTC"),
                                  average_speed: 3,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 12:16:52 UTC"),
                                  average_speed: 5,
                                  route_id: nil,
                                  user: user)

      data = Presenters::LocationPresenter.new(user).distance_location_and_average_speed
      expected = { "Denver, CO" => [[4.97, 6.71]] }

      expect(data).to eq(expected)
    end
  end
end
