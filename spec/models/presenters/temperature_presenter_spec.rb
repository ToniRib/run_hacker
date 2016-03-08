require "rails_helper"

RSpec.describe Presenters::TemperaturePresenter, type: :model do
  describe "#distance_temperature_and_total_time" do
    it "returns nested arrays for records with temp that include total time" do
      user = create(:user)
      workout1 = create(:workout, distance: 8000,
                                  temperature: 20,
                                  elapsed_time: 300,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  temperature: 40,
                                  elapsed_time: 500,
                                  user: user)

      data = Presenters::TemperaturePresenter.new(user).distance_temperature_and_total_time
      expected1 = [2.49, 40.0, 8.33]
      expected2 = [4.97, 20.0, 5.0]

      expect(data).to include(expected1)
      expect(data).to include(expected2)
    end

    it "does not return records with no temperature" do
      user = create(:user)
      workout1 = create(:workout, distance: 8000,
                                  temperature: 20,
                                  elapsed_time: 300,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  temperature: nil,
                                  elapsed_time: 500,
                                  user: user)

      data = Presenters::TemperaturePresenter.new(user).distance_temperature_and_total_time
      expected = [[4.97, 20.0, 5.0]]

      expect(data).to eq(expected)
    end
  end

  describe "#distance_temperature_and_average_speed" do
    it "returns nested arrays for records with temp that include avg speed" do
      user = create(:user)
      workout1 = create(:workout, distance: 8000,
                                  temperature: 20,
                                  average_speed: 3,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  temperature: 40,
                                  average_speed: 5,
                                  user: user)

      data = Presenters::TemperaturePresenter.new(user).distance_temperature_and_average_speed
      expected1 = [2.49, 40.0, 11.18]
      expected2 = [4.97, 20.0, 6.71]

      expect(data).to include(expected1)
      expect(data).to include(expected2)
    end

    it "does not return records with no temperature" do
      user = create(:user)
      workout1 = create(:workout, distance: 8000,
                                  temperature: 20,
                                  average_speed: 3,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  temperature: nil,
                                  average_speed: 5,
                                  user: user)

      data = Presenters::TemperaturePresenter.new(user).distance_temperature_and_average_speed
      expected = [[4.97, 20.0, 6.71]]

      expect(data).to eq(expected)
    end
  end

  describe "#distance_temperature_and_time_spent_resting" do
    it "returns nested arrays for records with temp that include rest time" do
      user = create(:user)
      workout1 = create(:workout, distance: 8000,
                                  temperature: 20,
                                  elapsed_time: 300,
                                  active_time: 275,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  temperature: 40,
                                  elapsed_time: 500,
                                  active_time: 450,
                                  user: user)

      data = Presenters::TemperaturePresenter.new(user).distance_temperature_and_time_spent_resting
      expected1 = [2.49, 40.0, 0.83]
      expected2 = [4.97, 20.0, 0.42]

      expect(data).to include(expected1)
      expect(data).to include(expected2)
    end

    it "does not return records with no temperature" do
      user = create(:user)
      workout1 = create(:workout, distance: 8000,
                                  temperature: 20,
                                  elapsed_time: 300,
                                  active_time: 275,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  temperature: nil,
                                  elapsed_time: 500,
                                  active_time: 450,
                                  user: user)

      data = Presenters::TemperaturePresenter.new(user).distance_temperature_and_time_spent_resting
      expected = [[4.97, 20.0, 0.42]]

      expect(data).to eq(expected)
    end

    it "does not return records where time spent resting is negative" do
      user = create(:user)
      workout1 = create(:workout, distance: 8000,
                                  temperature: 20,
                                  elapsed_time: 300,
                                  active_time: 275,
                                  user: user)
      workout2 = create(:workout, distance: 4000,
                                  temperature: 40,
                                  elapsed_time: 400,
                                  active_time: 450,
                                  user: user)

      data = Presenters::TemperaturePresenter.new(user).distance_temperature_and_time_spent_resting
      expected = [[4.97, 20.0, 0.42]]

      expect(data).to eq(expected)
    end
  end
end
