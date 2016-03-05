require "rails_helper"

RSpec.describe Api::V1::User::AggregatesController, type: :controller do
  describe "GET #index" do
    let(:json_response) { JSON.parse(response.body, symbolize_names: true) }

    it "responds with successful 200 HTTP status code" do
      user = create(:user_with_workouts_and_routes)

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      get :index

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "returns the user's aggregate workout data" do
      user = create(:user_with_workouts_and_routes)

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      get :index

      expect(json_response[:total_workouts]).to eq(2)
      expect(json_response[:total_distance]).to eq(10.11)
      expect(json_response[:total_time]).to eq(1.69)
      expect(json_response[:total_calories]).to eq(1300.0)
      expect(json_response[:date_joined]).to eq("Sep 20, 2011")
      expect(json_response[:average_run_distance]).to eq(5.06)
    end
  end
end
