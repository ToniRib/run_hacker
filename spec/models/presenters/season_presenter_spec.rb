require "rails_helper"

RSpec.describe Presenters::SeasonPresenter, type: :model do
  describe "#distance_season_and_total_time" do
    it "returns nested arrays for for records with elapsed times" do
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

      data = Presenters::SeasonPresenter.new(user).distance_season_and_total_time
      expected = { "Fall" => [[2.49, 8.33], [4.97, 5.0]] }

      expect(data).to eq(expected)
    end

    it "returns times grouped by location" do
      user = create(:user)
      workout1 = create(:workout, distance: 8000,
                                  elapsed_time: 300,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 19:16:52 UTC"),
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  elapsed_time: 500,
                                  starting_datetime:
                                    DateTime.parse("2011-01-20 12:16:52 UTC"),
                                  user: user)

      data = Presenters::SeasonPresenter.new(user).distance_season_and_total_time
      expected = { "Fall"   => [[4.97, 5.0]],
                   "Winter" => [[2.49, 8.33]]
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

      data = Presenters::SeasonPresenter.new(user).distance_season_and_total_time
      expected = { "Fall" => [[4.97, 5.0]] }

      expect(data).to eq(expected)
    end
  end

  describe "#distance_season_and_average_speed" do
    it "returns nested arrays for records with an average speed" do
      user = create(:user)
      workout1 = create(:workout, distance: 8000,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 19:16:52 UTC"),
                                  average_speed: 3,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  starting_datetime:
                                    DateTime.parse("2011-09-25 12:16:52 UTC"),
                                  average_speed: 5,
                                  user: user)

      data = Presenters::SeasonPresenter.new(user).distance_season_and_average_speed
      expected = { "Fall" => [[2.49, 11.18], [4.97, 6.71]] }

      expect(data).to eq(expected)
    end

    it "returns times grouped by location" do
      user = create(:user)
      workout1 = create(:workout, distance: 8000,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 19:16:52 UTC"),
                                  average_speed: 3,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  starting_datetime:
                                    DateTime.parse("2011-07-25 12:16:52 UTC"),
                                  average_speed: 5,
                                  user: user)

      data = Presenters::SeasonPresenter.new(user).distance_season_and_average_speed
      expected = { "Fall"   => [[4.97, 6.71]],
                   "Summer" => [[2.49, 11.18]]
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

      data = Presenters::SeasonPresenter.new(user).distance_season_and_average_speed
      expected = { "Fall" => [[4.97, 6.71]] }

      expect(data).to eq(expected)
    end
  end
end
