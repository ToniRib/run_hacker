require "rails_helper"

RSpec.describe Presenters::TimeOfDayPresenter, type: :model do
  describe "#distance_time_of_day_and_total_time" do
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

      data = Presenters::TimeOfDayPresenter.new(user).distance_time_of_day_and_total_time
      expected = [[2.49, [2016, 1, 1, 6, 16], 8.33], [4.97, [2016, 1, 1, 13, 16], 5.0]]

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

      data = Presenters::TimeOfDayPresenter.new(user).distance_time_of_day_and_total_time
      expected = [[4.97, [2016, 1, 1, 13, 16], 5.0]]

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

      data = Presenters::TimeOfDayPresenter.new(user).distance_time_of_day_and_total_time
      expected = [[4.97, [2016, 1, 1, 13, 16], 5.0]]

      expect(data).to eq(expected)
    end
  end

  describe "#distance_time_of_day_and_average_speed" do
    it "returns nested arrays for records with an average speed" do
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
                                  user: user)

      data = Presenters::TimeOfDayPresenter.new(user).distance_time_of_day_and_average_speed
      expected = [[2.49, [2016, 1, 1, 6, 16], 11.18], [4.97, [2016, 1, 1, 13, 16], 6.71]]

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

      data = Presenters::TimeOfDayPresenter.new(user).distance_time_of_day_and_average_speed
      expected = [[4.97, [2016, 1, 1, 13, 16], 6.71]]

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

      data = Presenters::TimeOfDayPresenter.new(user).distance_time_of_day_and_average_speed
      expected = [[4.97, [2016, 1, 1, 13, 16], 6.71]]

      expect(data).to eq(expected)
    end
  end

  describe "#distance_time_of_day_and_time_spent_resting" do
    it "returns nested arrays for records with all required parameters" do
      user = create(:user)
      workout1 = create(:workout, distance: 8000,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 19:16:52 UTC"),
                                  elapsed_time: 4000,
                                  active_time: 3000,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 12:16:52 UTC"),
                                  elapsed_time: 5000,
                                  active_time: 3000,
                                  user: user)

      data = Presenters::TimeOfDayPresenter.new(user).distance_time_of_day_and_time_spent_resting
      expected = [[2.49, [2016, 1, 1, 6, 16], 33.33], [4.97, [2016, 1, 1, 13, 16], 16.67]]

      expect(data).to eq(expected)
    end

    it "does not return records with no elapsed time" do
      user = create(:user)
      workout1 = create(:workout, distance: 8000,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 19:16:52 UTC"),
                                  elapsed_time: 4000,
                                  active_time: 3000,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 12:16:52 UTC"),
                                  elapsed_time: nil,
                                  active_time: 3000,
                                  user: user)

      data = Presenters::TimeOfDayPresenter.new(user).distance_time_of_day_and_time_spent_resting
      expected = [[4.97, [2016, 1, 1, 13, 16], 16.67]]

      expect(data).to eq(expected)
    end

    it "does not return records with no active time" do
      user = create(:user)
      workout1 = create(:workout, distance: 8000,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 19:16:52 UTC"),
                                  elapsed_time: 4000,
                                  active_time: 3000,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 12:16:52 UTC"),
                                  elapsed_time: 5000,
                                  active_time: nil,
                                  user: user)

      data = Presenters::TimeOfDayPresenter.new(user).distance_time_of_day_and_time_spent_resting
      expected = [[4.97, [2016, 1, 1, 13, 16], 16.67]]

      expect(data).to eq(expected)
    end

    it "does not return records with no associated route/location" do
      user = create(:user)
      workout1 = create(:workout, distance: 8000,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 19:16:52 UTC"),
                                  elapsed_time: 4000,
                                  active_time: 3000,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 12:16:52 UTC"),
                                  elapsed_time: 5000,
                                  active_time: 3000,
                                  route_id: nil,
                                  user: user)

      data = Presenters::TimeOfDayPresenter.new(user).distance_time_of_day_and_time_spent_resting
      expected = [[4.97, [2016, 1, 1, 13, 16], 16.67]]

      expect(data).to eq(expected)
    end

    it "does not return records where time spent resting is negative" do
      user = create(:user)
      workout1 = create(:workout, distance: 8000,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 19:16:52 UTC"),
                                  elapsed_time: 4000,
                                  active_time: 3000,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  starting_datetime:
                                    DateTime.parse("2011-09-20 12:16:52 UTC"),
                                  elapsed_time: 2000,
                                  active_time: 3000,
                                  user: user)

      data = Presenters::TimeOfDayPresenter.new(user).distance_time_of_day_and_time_spent_resting
      expected = [[4.97, [2016, 1, 1, 13, 16], 16.67]]

      expect(data).to eq(expected)
    end
  end
end
