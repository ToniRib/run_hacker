class Users::TemperatureController < Users::BaseController
  def index
    @workouts = current_user.workouts
  end
end
