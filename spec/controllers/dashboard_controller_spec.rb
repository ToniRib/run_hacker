require "rails_helper"

RSpec.describe DashboardController, type: :controller do
  describe "GET #show" do
    it "responds with successful 200 HTTP status code" do
      get :show

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
end
