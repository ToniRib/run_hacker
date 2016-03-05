require "rails_helper"

RSpec.describe User::WorkoutsController, type: :controller do
  describe "GET #index" do
    it "responds with successful 200 HTTP status code" do
      user = create(:user)
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      get :index

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    it "responds with successful 200 HTTP status code" do
      user = User.create(user_params)
      map_my_fitness_id = "932453273"
      workout = create(:workout, user: user, map_my_fitness_id: map_my_fitness_id)

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      VCR.use_cassette("load_time_series") do
        get :index
      end

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
end
